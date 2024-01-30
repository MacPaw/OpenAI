//
//  RunRetrieveStepsResult.swift
//  
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct RunRetrieveStepsResult: Codable, Equatable {
    
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
                public enum ToolType: String, Codable {
                    case codeInterpreter = "code_interpreter"
                    case function
                    case retrieval
                }
                
                public let id: String
                public let type: ToolType
                public let codeInterpreter: CodeInterpreterCall?
                public let function: FunctionCall?
                
                enum CodingKeys: String, CodingKey {
                    case id
                    case type
                    case codeInterpreter = "code_interpreter"
                    case function
                }

                public struct CodeInterpreterCall: Codable, Equatable {
                    public let input: String
                    public let outputs: [CodeInterpreterCallOutput]?

                    public struct CodeInterpreterCallOutput: Codable, Equatable {
                        public let type: String
                        public let logs: String?
                    }
                }
                
                public struct FunctionCall: Codable, Equatable {
                    public let name: String
                    public let arguments: String
                    public let output: String?
                }
            }
        }
    }

    public let data: [StepDetailsTopLevel]
}
