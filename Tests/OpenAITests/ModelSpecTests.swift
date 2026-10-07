//
//  ModelSpecTests.swift
//  OpenAI
//

import XCTest
@testable import OpenAI

class ModelSpecTests: XCTestCase {
    func testAllHasUniqueIDs() {
        let ids = ModelSpec.all.map(\.id)
        XCTAssertEqual(ids.count, Set(ids).count)
    }

    func testAllModelsIncludesSpecsMatchingFilter() {
        let chatCompletions = Model.allModels(satisfying: .init(supportedEndpoints: [.chatCompletions]))
        let responses = Model.allModels(satisfying: .init(supportedEndpoints: [.responses]))
        let mcp = Model.allModels(satisfying: .init(supportedEndpoints: [.responses], requiredTools: [.mcp]))

        for spec in ModelSpec.all {
            XCTAssertEqual(chatCompletions.contains(spec.id), spec.endpoints.contains(.chatCompletions), spec.id)
            XCTAssertEqual(responses.contains(spec.id), spec.endpoints.contains(.responses), spec.id)
            XCTAssertEqual(mcp.contains(spec.id), spec.endpoints.contains(.responses) && spec.tools.contains(.mcp), spec.id)
        }
    }

    func testAllModelsStillIncludesModelsWithoutSpec() {
        let responses = Model.allModels(satisfying: .init(supportedEndpoints: [.responses]))
        XCTAssertTrue(responses.contains(.gpt5))
        XCTAssertFalse(responses.contains(.gpt_4o_search_preview))
    }

    func testMCPFilterForModelsWithoutSpec() {
        let responses = Model.allModels(satisfying: .init(supportedEndpoints: [.responses]))
        let mcp = Model.allModels(satisfying: .init(supportedEndpoints: [.responses], requiredTools: [.mcp]))

        XCTAssertTrue(mcp.contains(.gpt4_o))
        // Supports Responses but not MCP, so only the tool filter can exclude it
        XCTAssertTrue(responses.contains(.chatgpt_4o_latest))
        XCTAssertFalse(mcp.contains(.chatgpt_4o_latest))
        XCTAssertFalse(mcp.contains(.computer_use_preview))
    }

    func testReasoningEffortConversions() {
        for effort in ModelSpec.ReasoningEffort.allCases {
            XCTAssertEqual(Components.Schemas.ReasoningEffort(effort).rawValue, effort.rawValue)
        }
        XCTAssertEqual(ChatQuery.ReasoningEffort(.none), .none)
        XCTAssertEqual(ChatQuery.ReasoningEffort(.high), .high)
        XCTAssertEqual(ChatQuery.ReasoningEffort(.xhigh), .customValue("xhigh"))
        XCTAssertEqual(ChatQuery.ReasoningEffort(.max), .customValue("max"))
    }

    func testLimitations() {
        XCTAssertEqual(ModelSpec.gpt6_astra.limitations, [.chatCompletionsFunctionCallingUnsupported])
        XCTAssertEqual(ModelSpec.gpt6_sol.limitations, [.chatCompletionsFunctionCallingRequiresReasoningEffortNone])
        XCTAssertEqual(ModelSpec.gpt6_luna.limitations, [.chatCompletionsFunctionCallingRequiresReasoningEffortNone])
        XCTAssertEqual(ModelSpec.gpt5_6_sol.limitations, [.chatCompletionsFunctionCallingRequiresReasoningEffortNone])
        XCTAssertEqual(ModelSpec.gpt5_6_terra.limitations, [.chatCompletionsFunctionCallingRequiresReasoningEffortNone])
        XCTAssertEqual(ModelSpec.gpt5_6_luna.limitations, [.chatCompletionsFunctionCallingRequiresReasoningEffortNone])
    }

    func testReasoningEfforts() {
        XCTAssertFalse(ModelSpec.gpt6_astra.reasoningEfforts.contains(.none))
        XCTAssertTrue(ModelSpec.gpt6_luna.reasoningEfforts.contains(.none))
        XCTAssertEqual(ModelSpec.gpt5_6_luna.reasoningEfforts, [.none, .low, .medium, .high, .xhigh, .max])
    }
}
