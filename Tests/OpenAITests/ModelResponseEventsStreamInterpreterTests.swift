//
//  ModelResponseEventsStreamInterpreterTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 10.04.2025.
//

import XCTest
@testable import OpenAI

@MainActor
final class ModelResponseEventsStreamInterpreterTests: XCTestCase {
    private let interpreter = ModelResponseEventsStreamInterpreter()

    func testParseApiError() async throws {
        let expectation = XCTestExpectation(description: "API Error callback received")
        var receivedError: Error?

        interpreter.setCallbackClosures { result in
            // This closure is for successful results, which we don't expect here
            XCTFail("Unexpected successful result received")
        } onError: { apiError in
            Task {
                await MainActor.run {
                    receivedError = apiError
                    expectation.fulfill() // Fulfill the expectation when the error is received
                }
            }
        }

        interpreter.processData(
            MockServerSentEvent.chatCompletionError()
        )

        // Wait for the expectation to be fulfilled, with a timeout
        await fulfillment(of: [expectation], timeout: 1.0)

        // Assert that an error was received and that it is of the expected type
        XCTAssertNotNil(receivedError, "Expected an error to be received, but got nil.")
        XCTAssertTrue(receivedError is APIErrorResponse, "Expected received error to be of type APIErrorResponse.")
    }

    func testParsesOutputTextDeltaUsingPayloadType() async throws {
        let expectation = XCTestExpectation(description: "OutputText delta event received")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error received: \(error)")
        }

        interpreter.processData(
            MockServerSentEvent.responseStreamEvent(
                itemId: "msg_1",
                payloadType: "response.output_text.delta",
                outputIndex: 0,
                contentIndex: 0,
                delta: "Hi",
                sequenceNumber: 1
            )
        )

        await fulfillment(of: [expectation], timeout: 1.0)

        guard let receivedEvent else {
            XCTFail("No event received")
            return
        }

        switch receivedEvent {
        case .outputText(.delta(let deltaEvent)):
            XCTAssertEqual(deltaEvent.itemId, "msg_1")
            XCTAssertEqual(deltaEvent.outputIndex, 0)
            XCTAssertEqual(deltaEvent.contentIndex, 0)
            XCTAssertEqual(deltaEvent.delta, "Hi")
            XCTAssertEqual(deltaEvent.sequenceNumber, 1)
        default:
            XCTFail("Expected .outputText(.delta), got \(receivedEvent)")
        }
    }

    func testOutputTextAnnotationAdded_withExplicitEventField() async throws {
        let expectation = XCTestExpectation(description: "outputTextAnnotation(.added) received via SSE event field")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error: \(error)")
        }

        interpreter.processData(MockServerSentEvent.annotationAddedEvent(withExplicitEventField: true))

        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .outputTextAnnotation(.added(let event)) = receivedEvent else {
            XCTFail("Expected .outputTextAnnotation(.added), got \(String(describing: receivedEvent))")
            return
        }
        XCTAssertEqual(event.itemId, "item_1")
        XCTAssertEqual(event.outputIndex, 0)
        XCTAssertEqual(event.contentIndex, 0)
        XCTAssertEqual(event.annotationIndex, 2)
        XCTAssertEqual(event.sequenceNumber, 5)
    }

    func testOutputTextAnnotationAdded_withoutEventField_fallsBackToPayloadType() async throws {
        let expectation = XCTestExpectation(description: "outputTextAnnotation(.added) received via data.type fallback")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error: \(error)")
        }

        interpreter.processData(MockServerSentEvent.annotationAddedEvent(withExplicitEventField: false))

        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .outputTextAnnotation(.added(let event)) = receivedEvent else {
            XCTFail("Expected .outputTextAnnotation(.added), got \(String(describing: receivedEvent))")
            return
        }
        XCTAssertEqual(event.itemId, "item_1")
        XCTAssertEqual(event.outputIndex, 0)
        XCTAssertEqual(event.contentIndex, 0)
        XCTAssertEqual(event.annotationIndex, 2)
        XCTAssertEqual(event.sequenceNumber, 5)
    }

    func testParsesReasoningTextDelta() async throws {
        let expectation = XCTestExpectation(description: "Reasoning delta event received")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error received: \(error)")
        }

        interpreter.processData(
            MockServerSentEvent.responseStreamEvent(
                itemId: "item_1",
                payloadType: "response.reasoning_text.delta",
                outputIndex: 0,
                contentIndex: 0,
                delta: "Because",
                sequenceNumber: 1
            )
        )

        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .reasoningText(.delta(let event)) = receivedEvent else {
            XCTFail("Expected .reasoningText(.delta), got \(String(describing: receivedEvent))")
            return
        }
        XCTAssertEqual(event.itemId, "item_1")
        XCTAssertEqual(event.delta, "Because")
        XCTAssertEqual(event.sequenceNumber, 1)
    }

    func testParsesReasoningTextDone() async throws {
        let expectation = XCTestExpectation(description: "Reasoning done event received")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error received: \(error)")
        }

        interpreter.processData(
            MockServerSentEvent.reasoningTextDoneEvent(
                itemId: "item_1",
                text: "Because the sky is blue.",
                sequenceNumber: 2
            )
        )

        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .reasoningText(.done(let event)) = receivedEvent else {
            XCTFail("Expected .reasoningText(.done), got \(String(describing: receivedEvent))")
            return
        }
        XCTAssertEqual(event.itemId, "item_1")
        XCTAssertEqual(event.text, "Because the sky is blue.")
        XCTAssertEqual(event.sequenceNumber, 2)
    }

    func testParsesCustomToolCallInputDelta() async throws {
        let expectation = XCTestExpectation(description: "Custom tool call input delta event received")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error received: \(error)")
        }

        interpreter.processData(
            MockServerSentEvent.responseStreamEvent(
                itemId: "item_1",
                payloadType: "response.custom_tool_call_input.delta",
                outputIndex: 0,
                delta: "{\"query\":",
                sequenceNumber: 1
            )
        )

        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .customToolCallInput(.delta(let event)) = receivedEvent else {
            XCTFail("Expected .customToolCallInput(.delta), got \(String(describing: receivedEvent))")
            return
        }
        XCTAssertEqual(event.itemId, "item_1")
        XCTAssertEqual(event.delta, "{\"query\":")
        XCTAssertEqual(event.sequenceNumber, 1)
    }

    func testParsesCustomToolCallInputDone() async throws {
        let expectation = XCTestExpectation(description: "Custom tool call input done event received")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error received: \(error)")
        }

        interpreter.processData(
            MockServerSentEvent.customToolCallInputDoneEvent(
                itemId: "item_1",
                input: "{\"query\":\"weather\"}",
                sequenceNumber: 2
            )
        )

        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .customToolCallInput(.done(let event)) = receivedEvent else {
            XCTFail("Expected .customToolCallInput(.done), got \(String(describing: receivedEvent))")
            return
        }
        XCTAssertEqual(event.itemId, "item_1")
        XCTAssertEqual(event.input, "{\"query\":\"weather\"}")
        XCTAssertEqual(event.sequenceNumber, 2)
    }

    func testParsesShellCallCommandAdded() async throws {
        let expectation = XCTestExpectation(description: "Shell call command added event received")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error received: \(error)")
        }

        interpreter.processData(
            MockServerSentEvent.shellCallCommandAddedEvent(
                outputIndex: 0,
                commandIndex: 1,
                command: "ls -la",
                sequenceNumber: 1
            )
        )

        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .shellCall(.command(.added(let event))) = receivedEvent else {
            XCTFail("Expected .shellCall(.command(.added)), got \(String(describing: receivedEvent))")
            return
        }
        XCTAssertEqual(event.outputIndex, 0)
        XCTAssertEqual(event.commandIndex, 1)
        XCTAssertEqual(event.command, "ls -la")
        XCTAssertEqual(event.sequenceNumber, 1)
    }

    func testParsesShellCallCommandDelta() async throws {
        let expectation = XCTestExpectation(description: "Shell call command delta event received")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error received: \(error)")
        }

        interpreter.processData(
            MockServerSentEvent.shellCallCommandDeltaEvent(
                outputIndex: 0,
                commandIndex: 1,
                delta: " -la",
                sequenceNumber: 2
            )
        )

        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .shellCall(.command(.delta(let event))) = receivedEvent else {
            XCTFail("Expected .shellCall(.command(.delta)), got \(String(describing: receivedEvent))")
            return
        }
        XCTAssertEqual(event.outputIndex, 0)
        XCTAssertEqual(event.commandIndex, 1)
        XCTAssertEqual(event.delta, " -la")
        XCTAssertEqual(event.sequenceNumber, 2)
    }

    func testParsesShellCallCommandDone() async throws {
        let expectation = XCTestExpectation(description: "Shell call command done event received")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error received: \(error)")
        }

        interpreter.processData(
            MockServerSentEvent.shellCallCommandDoneEvent(
                outputIndex: 0,
                commandIndex: 1,
                command: "ls -la",
                sequenceNumber: 3
            )
        )

        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .shellCall(.command(.done(let event))) = receivedEvent else {
            XCTFail("Expected .shellCall(.command(.done)), got \(String(describing: receivedEvent))")
            return
        }
        XCTAssertEqual(event.outputIndex, 0)
        XCTAssertEqual(event.commandIndex, 1)
        XCTAssertEqual(event.command, "ls -la")
        XCTAssertEqual(event.sequenceNumber, 3)
    }

    func testParsesShellCallOutputContentDelta() async throws {
        let expectation = XCTestExpectation(description: "Shell call output content delta event received")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error received: \(error)")
        }

        interpreter.processData(
            MockServerSentEvent.shellCallOutputContentDeltaEvent(
                itemId: "item_1",
                outputIndex: 0,
                commandIndex: 1,
                stdout: "hello",
                stderr: nil,
                sequenceNumber: 4
            )
        )

        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .shellCall(.outputContent(.delta(let event))) = receivedEvent else {
            XCTFail("Expected .shellCall(.outputContent(.delta)), got \(String(describing: receivedEvent))")
            return
        }
        XCTAssertEqual(event.itemId, "item_1")
        XCTAssertEqual(event.outputIndex, 0)
        XCTAssertEqual(event.commandIndex, 1)
        XCTAssertEqual(event.delta.stdout, "hello")
        XCTAssertNil(event.delta.stderr)
        XCTAssertEqual(event.sequenceNumber, 4)
    }

    func testParsesShellCallOutputContentDone() async throws {
        let expectation = XCTestExpectation(description: "Shell call output content done event received")
        var receivedEvent: ResponseStreamEvent?

        interpreter.setCallbackClosures { event in
            Task {
                await MainActor.run {
                    receivedEvent = event
                    expectation.fulfill()
                }
            }
        } onError: { error in
            XCTFail("Unexpected error received: \(error)")
        }

        interpreter.processData(
            MockServerSentEvent.shellCallOutputContentDoneEvent(
                itemId: "item_1",
                outputIndex: 0,
                commandIndex: 1,
                stdout: "hello\n",
                stderr: "",
                exitCode: 0,
                sequenceNumber: 5
            )
        )

        await fulfillment(of: [expectation], timeout: 1.0)

        guard case .shellCall(.outputContent(.done(let event))) = receivedEvent else {
            XCTFail("Expected .shellCall(.outputContent(.done)), got \(String(describing: receivedEvent))")
            return
        }
        XCTAssertEqual(event.itemId, "item_1")
        XCTAssertEqual(event.outputIndex, 0)
        XCTAssertEqual(event.commandIndex, 1)
        XCTAssertEqual(event.output.count, 1)
        XCTAssertEqual(event.output.first?.stdout, "hello\n")
        XCTAssertEqual(event.output.first?.stderr, "")
        guard case .functionShellCallOutputExitOutcome(let outcome) = event.output.first?.outcome else {
            XCTFail("Expected .functionShellCallOutputExitOutcome, got \(String(describing: event.output.first?.outcome))")
            return
        }
        XCTAssertEqual(outcome.exitCode, 0)
        XCTAssertEqual(event.sequenceNumber, 5)
    }
}
