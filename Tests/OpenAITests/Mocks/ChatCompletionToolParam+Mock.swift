//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//

@testable import OpenAI
import Foundation

extension ChatQuery.ChatCompletionToolParam {
    static func makeWeatherMock() -> ChatQuery.ChatCompletionToolParam {
        .init(
            function: .init(
                name: "get_current_weather",
                description: "Get the current weather in a given location",
                parameters: .init(fields: [
                    .type(.object),
                    .properties([
                        "location": .init(fields: [
                            .type(.string),
                            .description("The city and state, e.g. San Francisco, CA")
                        ]),
                        "unit": .init(fields: [
                            .type(.string),
                            .enumValues(["celsius", "fahrenheit"])
                        ])
                    ]),
                    .required(["location"])
                ])
            )
        )
    }
}
