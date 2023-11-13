//
//  AudioSpeechResult.swift
//
//
//  Created by Ihor Makhnyk on 13.11.2023.
//

import Foundation
import AVFoundation

public struct AudioSpeechResult {
    
    /// Audio data for one of the following formats :`mp3`, `opus`, `aac`, `flac`
    public let audioData: Data?
    
    /// Saves the audio data to a file at a specified file path.
    ///
    /// - Parameters:
    ///     - name: The name for the file.
    ///     - format: The format of the audio data, as defined in **`AudioSpeechQuery.AudioSpeechResponseFormat`**.  For example: **`.mp3`**
    ///     - path: The destination file path as an URL.
    /// - Throws: Throws an NSError if there is an issue with writing the data to the specified file path.
    public func saveAs(_ name: String, format: AudioSpeechQuery.AudioSpeechResponseFormat, to path: URL) throws {
        guard let data = audioData else {
            throw NSError(
                domain: Bundle.main.bundleIdentifier!,
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "No audio data"]
            )
        }
        let filename = "\(name).\(format.rawValue)"
        let fileURL = path.appendingPathComponent(filename)
        try data.write(to: fileURL)
    }
    
    /// Gets an `AVAudioPlayer` instance configured with the audio data.
    ///
    /// - Returns: An `AVAudioPlayer` instance or nil if there is no audio data or if there is issue initializing an `AVAudioPlayer`.
    /// - Note: Import **AVFoundation**
    public func getAudioPlayer() -> AVAudioPlayer? {
        guard let data = audioData else {
            NSLog("No audio data")
            return nil
        }
        
        do {
            let audioPlayer = try AVAudioPlayer(data: data)
            return audioPlayer
        } catch {
            NSLog("Error initializing audio player: \(error)")
            return nil
        }
    }
    
}
