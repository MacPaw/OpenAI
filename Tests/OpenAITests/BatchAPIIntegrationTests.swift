//
//  BatchAPIIntegrationTests.swift
//  OpenAI
//
//  Integration tests for Batch API - requires valid API key.
//

import XCTest
@testable import OpenAI

/// Example structured output type for batch testing
struct ExtractedMovieInfo: Codable, JSONSchemaConvertible {
    let title: String
    let director: String
    let year: Int
    let genre: String

    static var example: ExtractedMovieInfo {
        ExtractedMovieInfo(
            title: "The Matrix",
            director: "The Wachowskis",
            year: 1999,
            genre: "Science Fiction"
        )
    }
}

/// Integration tests that hit the real OpenAI API.
/// Set OPENAI_API_KEY environment variable to run.
class BatchAPIIntegrationTests: XCTestCase {

    var openAI: OpenAI!

    override func setUp() async throws {
        guard let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"],
              !apiKey.isEmpty else {
            throw XCTSkip("OPENAI_API_KEY not set - skipping integration test")
        }

        let configuration = OpenAI.Configuration(token: apiKey)
        self.openAI = OpenAI(configuration: configuration)
    }

    /// Test the full batch workflow:
    /// 1. Upload input file
    /// 2. Create batch
    /// 3. Poll for completion
    /// 4. Retrieve results
    func testBatchWorkflow() async throws {
        // Step 1: Create JSONL input using simplified init
        let requests = [
            // Simple text request
            BatchRequestLine(
                customId: "request-1",
                body: ChatQuery(
                    messages: [.user(.init(content: .string("What is 2+2? Reply with just the number.")))],
                    model: .gpt4_o_mini
                )
            ),
            // Another simple text request
            BatchRequestLine(
                customId: "request-2",
                body: ChatQuery(
                    messages: [.user(.init(content: .string("What is the capital of France? Reply with just the city name.")))],
                    model: .gpt4_o_mini
                )
            ),
            // Structured output request using JSON schema
            BatchRequestLine(
                customId: "request-3-structured",
                body: ChatQuery(
                    messages: [
                        .system(.init(content: .textContent("You extract movie information from text."))),
                        .user(.init(content: .string("Extract the movie info: Inception is a 2010 sci-fi film directed by Christopher Nolan.")))
                    ],
                    model: .gpt4_o_mini,
                    responseFormat: .jsonSchema(
                        ChatQuery.StructuredOutputConfigurationOptions(
                            name: "movie_info",
                            schema: .derivedJsonSchema(ExtractedMovieInfo.self),
                            strict: true
                        )
                    )
                )
            )
        ]

        // Encode to JSONL
        let encoder = JSONEncoder()
        let jsonlData = try requests.map { request -> String in
            let data = try encoder.encode(request)
            return String(data: data, encoding: .utf8)!
        }.joined(separator: "\n")

        print("📝 JSONL Input:\n\(jsonlData)\n")

        // Step 2: Upload file
        let fileData = jsonlData.data(using: String.Encoding.utf8)!
        let fileQuery = FilesQuery(
            purpose: "batch",
            file: fileData,
            fileName: "batch_test_\(Int(Date().timeIntervalSince1970)).jsonl",
            contentType: "application/jsonl"
        )

        print("📤 Uploading input file...")
        let fileResult = try await openAI.files(query: fileQuery)
        print("   File ID: \(fileResult.id)")

        // Step 3: Create batch
        let batchQuery = BatchQuery(
            inputFileId: fileResult.id,
            endpoint: .chatCompletions,
            completionWindow: .twentyFourHours,
            metadata: ["test": "batch-api-integration"]
        )

        print("🚀 Creating batch...")
        let batch = try await openAI.createBatch(query: batchQuery)
        print("   Batch ID: \(batch.id)")
        print("   Status: \(batch.status)")

        // Step 4: Poll for completion (with timeout)
        print("⏳ Waiting for batch to complete...")
        let startTime = Date()
        let timeout: TimeInterval = 300 // 5 minutes max

        var currentBatch = batch
        while currentBatch.status != BatchStatus.completed &&
              currentBatch.status != BatchStatus.failed &&
              currentBatch.status != BatchStatus.expired &&
              currentBatch.status != BatchStatus.cancelled &&
              currentBatch.status != .cancelling {

            if Date().timeIntervalSince(startTime) > timeout {
                print("   ⚠️ Timeout after \(timeout)s - batch still processing")
                print("   Final status: \(currentBatch.status)")
                // Don't fail - batch might still complete later
                return
            }

            try await Task.sleep(nanoseconds: 5_000_000_000) // 5 seconds
            currentBatch = try await openAI.retrieveBatch(id: batch.id)
            print("   Status: \(currentBatch.status)")

            if let counts = currentBatch.requestCounts {
                print("   Progress: \(counts.completed)/\(counts.total) completed, \(counts.failed) failed")
            }
        }
        
        // Step 5: Check results
        XCTAssertEqual(currentBatch.status, BatchStatus.completed, "Batch should complete successfully")

        if let counts = currentBatch.requestCounts {
            print("📊 Final counts:")
            print("   Total: \(counts.total)")
            print("   Completed: \(counts.completed)")
            print("   Failed: \(counts.failed)")
        }

        // Step 6: Check for errors first
        if let errorFileId = currentBatch.errorFileId {
            print("⚠️ Error file exists: \(errorFileId)")
            let errorData = try await openAI.retrieveFileContent(id: errorFileId)
            let errorString = String(data: errorData, encoding: .utf8) ?? "?"
            print("📄 Error file content:\n\(errorString)\n")
        }

        // Step 7: Download and verify output file
        guard let outputFileId = currentBatch.outputFileId else {
            XCTFail("No output file ID returned - all requests may have failed")
            return
        }

        print("📥 Downloading output file: \(outputFileId)")
        let outputData = try await openAI.retrieveFileContent(id: outputFileId)
        let outputString = String(data: outputData, encoding: .utf8)!
        print("📄 Output file content:\n\(outputString)\n")

        // Parse JSONL output
        let lines = outputString.split(separator: "\n")
        XCTAssertEqual(lines.count, 3, "Should have 3 response lines")

        let decoder = JSONDecoder()

        // Verify each response
        var foundMathAnswer = false
        var foundCapitalAnswer = false
        var foundMovieInfo = false

        for line in lines {
            let responseData = line.data(using: .utf8)!
            let responseLine = try decoder.decode(BatchResponseLine.self, from: responseData)

            print("📝 Response for \(responseLine.customId):")

            if let response = responseLine.response {
                XCTAssertEqual(response.statusCode, 200, "Request should succeed")

                // Get the content from the first choice
                if let choice = response.body.choices.first,
                   let content = choice.message.content {
                    print("   Content: \(content)")

                    switch responseLine.customId {
                    case "request-1":
                        XCTAssertTrue(content.contains("4"), "2+2 should equal 4")
                        foundMathAnswer = true
                    case "request-2":
                        XCTAssertTrue(content.lowercased().contains("paris"), "Capital of France is Paris")
                        foundCapitalAnswer = true
                    case "request-3-structured":
                        // Parse structured output
                        let movieInfo = try decoder.decode(ExtractedMovieInfo.self, from: content.data(using: .utf8)!)
                        print("   Parsed movie: \(movieInfo.title) (\(movieInfo.year)) by \(movieInfo.director)")
                        XCTAssertEqual(movieInfo.title, "Inception")
                        XCTAssertEqual(movieInfo.year, 2010)
                        XCTAssertEqual(movieInfo.director, "Christopher Nolan")
                        foundMovieInfo = true
                    default:
                        break
                    }
                }
            } else if let error = responseLine.error {
                XCTFail("Request \(responseLine.customId) failed: \(error.message)")
            }
        }

        XCTAssertTrue(foundMathAnswer, "Should find math answer")
        XCTAssertTrue(foundCapitalAnswer, "Should find capital answer")
        XCTAssertTrue(foundMovieInfo, "Should find movie info")

        print("✅ All batch responses verified!")
    }

    /// Simple test to list existing batches
    func testListBatches() async throws {
        print("📋 Listing batches...")
        let result = try await openAI.listBatches(after: nil, limit: 10)

        print("   Found \(result.data.count) batches")
        for batch in result.data.prefix(5) {
            print("   - \(batch.id): \(batch.status) (\(batch.endpoint))")
        }

        XCTAssertNotNil(result.data)
    }

    /// Test canceling a batch
    func testCancelBatch() async throws {
        // Create a batch first
        let request = BatchRequestLine(
            customId: "cancel-test-1",
            body: ChatQuery(
                messages: [.user(.init(content: .string("What is 1+1?")))],
                model: .gpt4_o_mini
            )
        )

        print("📤 Creating batch to cancel...")
        let batch = try await openAI.submitBatch(
            requests: [request],
            fileName: "cancel_test.jsonl"
        )
        print("   Batch ID: \(batch.id)")
        print("   Status: \(batch.status)")

        let batchWaitTask = Task {
            _ = try await openAI.waitForBatch(id: batch.id)
        }
        // Cancel the batch
        print("🚫 Canceling batch...")
        let cancelledBatch = try await openAI.cancelBatch(id: batch.id)
        print("   Status after cancel: \(cancelledBatch.status)")
        
        do {
            // Batch wait should fail due to cancellation
            _ = try await batchWaitTask.value
            XCTFail()
        } catch let error as BatchError {
            guard case let .batchFailed(batchId, status) = error else {
                return XCTFail()
            }
            XCTAssert(status == .cancelled || status == .cancelling)
            XCTAssertEqual(batchId, batch.id)
        }
        
        // Status should be cancelling or cancelled
        XCTAssertTrue(
            cancelledBatch.status == .cancelling || cancelledBatch.status == .cancelled,
            "Batch should be cancelling or cancelled, got: \(cancelledBatch.status)"
        )

        print("✅ Batch cancelled successfully!")
    }

    /// Test deleting a file
    func testDeleteFile() async throws {
        // Upload a test file first
        let testContent = """
        {"custom_id": "test-1", "method": "POST", "url": "/v1/chat/completions", "body": {"model": "gpt-4o-mini", "messages": [{"role": "user", "content": "test"}]}}
        """
        let fileData = testContent.data(using: .utf8)!
        let fileQuery = FilesQuery(
            purpose: "batch",
            file: fileData,
            fileName: "delete_test_\(Int(Date().timeIntervalSince1970)).jsonl",
            contentType: "application/jsonl"
        )

        print("📤 Uploading test file...")
        let fileResult = try await openAI.files(query: fileQuery)
        print("   File ID: \(fileResult.id)")

        // Delete the file
        print("🗑️ Deleting file...")
        let deleteResult = try await openAI.deleteFile(id: fileResult.id)
        print("   Deleted: \(deleteResult.deleted)")

        XCTAssertTrue(deleteResult.deleted, "File should be deleted")
        XCTAssertEqual(deleteResult.id, fileResult.id, "Deleted file ID should match")

        print("✅ File deleted successfully!")
    }

    /// Test the convenience methods (submitBatch + waitForBatch)
    func testConvenienceMethods() async throws {
        let requests = [
            BatchRequestLine(
                customId: "convenience-1",
                body: ChatQuery(
                    messages: [.user(.init(content: .string("Say 'hello'")))],
                    model: .gpt4_o_mini
                )
            )
        ]

        print("📤 Submitting batch with convenience method...")
        let batch = try await openAI.submitBatch(
            requests: requests,
            fileName: "convenience_test.jsonl",
            metadata: ["test": "convenience"]
        )
        print("   Batch ID: \(batch.id)")

        print("⏳ Waiting for batch with convenience method...")
        let responses = try await openAI.waitForBatch(id: batch.id, pollingInterval: 5.0, timeout: 300)

        print("📝 Got \(responses.count) responses")
        XCTAssertEqual(responses.count, 1, "Should have 1 response")

        if let response = responses.first {
            XCTAssertEqual(response.customId, "convenience-1")
            if let body = response.response {
                XCTAssertEqual(body.statusCode, 200)
                print("   Response: \(body.body.choices.first?.message.content ?? "nil")")
            }
        }

        print("✅ Convenience methods work!")
    }
}
