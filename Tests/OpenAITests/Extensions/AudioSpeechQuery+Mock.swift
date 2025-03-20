//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.03.2025.
//

import Foundation
@testable import OpenAI

extension AudioSpeechQuery {
    static let mock: AudioSpeechQuery = .init(model: .tts_1, input: "Hello, world!", voice: .alloy)
}
