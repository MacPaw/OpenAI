//
//  AudioSpeechStreamInterpreter.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 07.03.2025.
//

import Foundation

class AudioSpeechStreamInterpreter: StreamInterpreter {
    typealias ResultType = AudioSpeechResult
    
    var onEventDispatched: ((AudioSpeechResult) -> Void)?
    
    func processData(_ data: Data) throws {
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode(APIErrorResponse.self, from: data) {
            throw decoded
        }
        
        let result = AudioSpeechResult(audio: data)
        onEventDispatched?(result)
    }
}
