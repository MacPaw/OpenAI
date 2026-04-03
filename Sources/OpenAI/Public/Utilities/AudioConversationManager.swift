//
//  AudioConversationManager.swift
//
//
//  Created by OpenAI SDK Contributors.
//

import Foundation

/// Manages multi-turn audio conversations with history tracking
///
/// This actor provides a convenient way to manage audio conversations using the audio chat API.
/// It automatically handles conversation history, including system prompts and message tracking.
///
/// Example:
/// ```swift
/// let manager = AudioConversationManager(
///     openAI: openAI,
///     systemPrompt: "You are a helpful voice assistant"
/// )
///
/// // Send audio and get response
/// let (audioData, transcript) = try await manager.sendAudio(userAudioData)
/// ```
@available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
public actor AudioConversationManager {
    private var conversationHistory: [AudioChatQuery.Message] = []
    private let openAI: OpenAIProtocol
    private let systemPrompt: String?
    private let maxHistoryTurns: Int

    /// Initialize a new audio conversation manager
    ///
    /// - Parameters:
    ///   - openAI: The OpenAI client instance
    ///   - systemPrompt: Optional system prompt to set context for the conversation
    ///   - maxHistoryTurns: Maximum number of conversation turns to keep in history (default: 10)
    public init(openAI: OpenAIProtocol, systemPrompt: String? = nil, maxHistoryTurns: Int = 10) {
        self.openAI = openAI
        self.systemPrompt = systemPrompt
        self.maxHistoryTurns = maxHistoryTurns

        if let systemPrompt = systemPrompt {
            conversationHistory.append(.init(
                role: .system,
                content: .text(systemPrompt)
            ))
        }
    }

    /// Send audio message and get audio response
    ///
    /// - Parameters:
    ///   - audioData: The audio data to send
    ///   - audioFormat: Format of the input audio (default: wav). Only wav and mp3 are supported for input
    ///   - voice: Voice to use for response (default: alloy)
    ///   - responseFormat: Format for the response audio (default: pcm16 for optimal streaming)
    /// - Returns: A tuple containing the audio data and transcript of the response
    /// - Throws: AudioConversationError or networking errors
    public func sendAudio(
        _ audioData: Data,
        audioFormat: AudioFormat = .wav,
        voice: AudioChatQuery.AudioConfig.Voice = .alloy,
        responseFormat: AudioFormat = .pcm16
    ) async throws -> (audioData: Data, transcript: String) {

        let base64Audio = audioData.base64EncodedString()

        let userMessage = AudioChatQuery.Message(
            role: .user,
            content: .parts([
                .init(inputAudio: .init(data: base64Audio, format: audioFormat))
            ])
        )

        conversationHistory.append(userMessage)

        // Prune history if needed
        pruneHistoryIfNeeded()

        let query = AudioChatQuery(
            model: .gpt_4o_audio_preview,
            messages: conversationHistory,
            modalities: [.text, .audio],
            audio: .init(voice: voice, format: responseFormat)
        )

        let result = try await openAI.audioChats(query: query)

        guard let choice = result.choices.first,
              let audio = choice.message.audio else {
            throw AudioConversationError.noAudioResponse
        }

        let assistantMessage = AudioChatQuery.Message(
            role: .assistant,
            content: .text(audio.transcript)
        )
        conversationHistory.append(assistantMessage)

        guard let audioData = Data(base64Encoded: audio.data) else {
            throw AudioConversationError.invalidAudioData
        }

        return (audioData, audio.transcript)
    }

    /// Send text message and get audio response
    ///
    /// - Parameters:
    ///   - text: The text message to send
    ///   - voice: Voice to use for response (default: alloy)
    ///   - responseFormat: Format for the response audio (default: pcm16)
    /// - Returns: A tuple containing the audio data and transcript of the response
    /// - Throws: AudioConversationError or networking errors
    public func sendText(
        _ text: String,
        voice: AudioChatQuery.AudioConfig.Voice = .alloy,
        responseFormat: AudioFormat = .pcm16
    ) async throws -> (audioData: Data, transcript: String) {

        let userMessage = AudioChatQuery.Message(
            role: .user,
            content: .text(text)
        )

        conversationHistory.append(userMessage)

        // Prune history if needed
        pruneHistoryIfNeeded()

        let query = AudioChatQuery(
            model: .gpt_4o_audio_preview,
            messages: conversationHistory,
            modalities: [.text, .audio],
            audio: .init(voice: voice, format: responseFormat)
        )

        let result = try await openAI.audioChats(query: query)

        guard let choice = result.choices.first,
              let audio = choice.message.audio else {
            throw AudioConversationError.noAudioResponse
        }

        let assistantMessage = AudioChatQuery.Message(
            role: .assistant,
            content: .text(audio.transcript)
        )
        conversationHistory.append(assistantMessage)

        guard let audioData = Data(base64Encoded: audio.data) else {
            throw AudioConversationError.invalidAudioData
        }

        return (audioData, audio.transcript)
    }

    /// Clear conversation history (keeps system prompt if provided)
    public func reset() {
        conversationHistory.removeAll()
        if let systemPrompt = systemPrompt {
            conversationHistory.append(.init(
                role: .system,
                content: .text(systemPrompt)
            ))
        }
    }

    /// Get current conversation transcript as a formatted string
    ///
    /// - Returns: A multi-line string with the conversation history
    public func getTranscript() -> String {
        conversationHistory
            .compactMap { message -> String? in
                switch message.content {
                case .text(let text):
                    return "\(message.role.rawValue): \(text)"
                case .parts(let parts):
                    let textParts = parts.compactMap { $0.text }
                    if textParts.isEmpty {
                        return "\(message.role.rawValue): [audio]"
                    }
                    return "\(message.role.rawValue): \(textParts.joined(separator: " "))"
                }
            }
            .joined(separator: "\n")
    }

    /// Get the current number of messages in the conversation history
    public func getMessageCount() -> Int {
        conversationHistory.count
    }

    // MARK: - Private Methods

    private func pruneHistoryIfNeeded() {
        // Keep system message + last N turns (each turn is user + assistant = 2 messages)
        let maxMessages = maxHistoryTurns * 2

        if conversationHistory.count > maxMessages {
            let systemMessages = conversationHistory.filter { $0.role == .system }
            let recentMessages = Array(conversationHistory.suffix(maxMessages))
            conversationHistory = systemMessages + recentMessages.filter { $0.role != .system }
        }
    }
}

/// Errors that can occur during audio conversation management
public enum AudioConversationError: Error, LocalizedError {
    case noAudioResponse
    case invalidAudioData

    public var errorDescription: String? {
        switch self {
        case .noAudioResponse:
            return "No audio response received from the API"
        case .invalidAudioData:
            return "Invalid audio data received - could not decode base64"
        }
    }
}
