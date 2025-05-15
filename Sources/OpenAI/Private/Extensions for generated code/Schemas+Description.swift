//
//  Schemas+Description.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 06.04.2025.
//

import Foundation

extension Components.Schemas.ResponseCreatedEvent: CustomStringConvertible {
    public var description: String {
        "ResponseCreatedEvent(type: \(_type.rawValue), response: \(response)"
    }
}

extension Components.Schemas.Response: CustomStringConvertible {
    public var description: String {
        "Response(modelResponse: \(value1), response: \(value2), value3: \(value3))"
    }
}

extension Components.Schemas.ModelResponseProperties: CustomStringConvertible {
    public var description: String {
        let parts: [String] = [
                    "metadata: \(metadata.map(String.init(describing:)) ?? "nil")",
                    "temperature: \(temperature.map(String.init(describing:)) ?? "nil")",
                    "topP: \(topP.map(String.init(describing:)) ?? "nil")",
                    "user: \(user.map { "\"\($0)\"" } ?? "nil")"
        ]
        
        return "ModelResponseProperties(\(parts.joined(separator: ", ")))"
    }
}

extension Components.Schemas.ResponseTextDeltaEvent: CustomStringConvertible {
    public var description: String {
        "ResponseTextDeltaEvent(itemId: \"\(itemId)\", outputIndex: \(outputIndex), contentIndex: \(contentIndex), delta: \"\(delta)\")"
    }
}

extension Components.Schemas.ResponseTextAnnotationDeltaEvent: CustomStringConvertible {
    public var description: String {
        "ResponseTextAnnotationDeltaEvent(itemId: \"\(itemId)\", outputIndex: \(outputIndex), contentIndex: \(contentIndex), annotationIndex: \(annotationIndex), annotation: \(annotation))"
    }
}

extension Components.Schemas.ResponseTextDoneEvent: CustomStringConvertible {
    public var description: String {
        "ResponseTextDoneEvent(itemId: \"\(itemId)\", outputIndex: \(outputIndex), contentIndex: \(contentIndex), text: \"\(text)\")"
    }
}
