//
//  RunRetreiveStepsResult.swift
//  
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct RunRetreiveStepsResult: Codable, Equatable {
    
    public struct StepDetailsTopLevel: Codable, Equatable {
        public let id: String
        public let stepDetails: StepDetailsSecondLevel

        enum CodingKeys: String, CodingKey {
            case id
            case stepDetails = "step_details"
        }

        public struct StepDetailsSecondLevel: Codable, Equatable {

            public let toolCalls: [ToolCall]?

            enum CodingKeys: String, CodingKey {
                case toolCalls = "tool_calls"
            }

            public struct ToolCall: Codable, Equatable {
                public let id: String
                public let type: String
                public let code: CodeToolCall?
                
                enum CodingKeys: String, CodingKey {
                    case id
                    case type
                    case code = "code_interpreter"
                }

                public struct CodeToolCall: Codable, Equatable {
                    public let input: String
                    public let outputs: [CodeToolCallOutput]?

                    public struct CodeToolCallOutput: Codable, Equatable {
                        public let type: String
                        public let logs: String?

                    }
                }
            }
        }
    }

    public let data: [StepDetailsTopLevel]
}
