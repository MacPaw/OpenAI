import XCTest
@testable import OpenAI

final class OpenAITests: XCTestCase {
    
    var openAI: OpenAI!
    
    override func setUp() {
        super.setUp()
        self.openAI = OpenAI(apiToken: "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")
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
}
