//
//  ChatQuery+CustomStringConvertible.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 19.11.2025.
//

import Foundation

extension ChatQuery: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String { jsonDescription(prettyPrinted: true) }

    public var debugDescription: String { jsonDescription(prettyPrinted: true) }

    private func jsonDescription(prettyPrinted: Bool) -> String {
        let encoder = JSONEncoder()
        var formatting: JSONEncoder.OutputFormatting = [.sortedKeys]
        if prettyPrinted {
            formatting.insert(.prettyPrinted)
        }
        encoder.outputFormatting = formatting
        guard
            let data = try? encoder.encode(self),
            let string = String(data: data, encoding: .utf8)
        else {
            return "ChatQuery(model: \(model), messages: \(messages.count))"
        }
        return string
    }
}
