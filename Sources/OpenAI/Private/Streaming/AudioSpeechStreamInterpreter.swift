//
//  AudioSpeechStreamInterpreter.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 07.03.2025.
//

import Foundation

final class AudioSpeechStreamInterpreter: @unchecked Sendable, StreamInterpreter {
    typealias ResultType = AudioSpeechResult
    
    private var onEventDispatched: ((AudioSpeechResult) -> Void)?
    private var onError: ((Error) -> Void)?
    private let executionSerializer: ExecutionSerializer
    
    init(executionSerializer: ExecutionSerializer = GCDQueueAsyncExecutionSerializer(queue: .userInitiated)) {
        self.executionSerializer = executionSerializer
    }
    
    func setCallbackClosures(onEventDispatched: @escaping (AudioSpeechResult) -> Void, onError: @escaping (any Error) -> Void) {
        executionSerializer.dispatch {
            self.onEventDispatched = onEventDispatched
            self.onError = onError
        }
    }
    
    func processData(_ data: Data) {
        executionSerializer.dispatch {
            let decoder = JSONDecoder()
            if let decoded = JSONResponseErrorDecoder(decoder: decoder).decodeErrorResponse(data: data) {
                self.onError?(decoded)
            }
            
            let result = AudioSpeechResult(audio: data)
            self.onEventDispatched?(result)
        }
    }
}
