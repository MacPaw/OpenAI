import XCTest
@testable import OpenAI

final class OpenAITests: XCTestCase {

    var openAI: OpenAI!

    override func setUp() {
        super.setUp()
        self.openAI = OpenAI(apiToken: "<YOUR TOKEN HERE>")
    }

    func testCompletions() {
        let expectation = expectation(description: "wait")
        openAI.completions(query: .init(model: .textDavinci_003, prompt: "What is 42?", temperature: 0, max_tokens: 100, top_p: 1, frequency_penalty: 0, presence_penalty: 0, stop: ["\\n"])) { result in
            switch result {
            case .success(let result):
                XCTAssert(true, "Result received - \(result)")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }

    func testImages() {
        let expectation = expectation(description: "wait")
        openAI.images(query: .init(prompt: "White cat with heterochromia sitting on the kitchen table", n: 1, size: "1024x1024")) { result in
            switch result {
            case .success(let result):
                XCTAssert(true, "Result received - \(result)")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }

    func testEmbeddings() {
        let expectation = expectation(description: "wait")
        openAI.embeddings(query: .init(model: .textSearchBabbadgeDoc, input: "The food was delicious and the waiter...")) { result in
            switch result {
            case .success(let result):
                XCTAssert(true, "Result received - \(result)")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }

    func testSimilarity_Similar() {
        let vector1 = [0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251]
        let vector2 = [0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251]
        let similarity = Vector.cosineSimilarity(a: vector1, b: vector2)
        print(similarity)
        XCTAssertEqual(similarity, 1.0, accuracy: 0.000001)
    }

    func testSimilarity_NotSimilar() {
        let vector1 = [0.213123, 0.3214124, 0.421412, 0.3214521251, 0.412412, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.4214214, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251]
        let vector2 = [0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.511515, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3213213]
        let similarity = Vector.cosineSimilarity(a: vector1, b: vector2)
        print(similarity)
        XCTAssertEqual(similarity, 0.9510201910206734, accuracy: 0.000001)
    }

    func testMakeRequest_bodyContainsFractional() throws {
        let query = OpenAI.CompletionsQuery(model: .textDavinci_003, prompt: "What is 42?", temperature: 0.7, max_tokens: 100)
        let request = try openAI.makeRequest(query: query, url: .completions)
        let json = try JSONSerialization.jsonObject(with: request.httpBody!, options: []) as! [String: Any]
        XCTAssertEqual(json["temperature"] as? Double, 0.7)
    }
}
