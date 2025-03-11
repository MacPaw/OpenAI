//
//  RunToolOutputsQuery.swift
//
//
//  Created by Brent Whitman on 2024-01-29.
//

import Foundation

public struct RunToolOutputsQuery: Codable, Equatable, Sendable {
    public struct ToolOutput: Codable, Equatable, Sendable {
        public let toolCallId: String?
        public let output: String?
        
        enum CodingKeys: String, CodingKey {
            case toolCallId = "tool_call_id"
            case output
        }
        
        public init(toolCallId: String?, output: String?) {
            self.toolCallId = toolCallId
            self.output = output
        }
    }
    
    public let toolOutputs: [ToolOutput]
    
    enum CodingKeys: String, CodingKey {
        case toolOutputs = "tool_outputs"
    }
    
    public init(toolOutputs: [ToolOutput]) {
        self.toolOutputs = toolOutputs
    }
}
