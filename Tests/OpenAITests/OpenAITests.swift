import XCTest
@testable import OpenAI

@available(iOS 13.0, *)
@available(watchOS 6.0, *)
@available(tvOS 13.0, *)
final class OpenAITests: XCTestCase {

    var openAI: OpenAI!

    override func setUp() {
        super.setUp()
        self.openAI = OpenAI(apiToken: "<YOUR TOKEN HERE>")
    }

    func testCompletionsAsync() async throws {
        let query = OpenAI.CompletionsQuery(model: .textDavinci_003, prompt: "What is 42?", temperature: 0, max_tokens: 100, top_p: 1, frequency_penalty: 0, presence_penalty: 0, stop: ["\\n"])
        let result = try await openAI.completions(query: query)
        XCTAssertFalse(result.choices.isEmpty)
    }
    
    func testImages() async throws {
        let query = OpenAI.ImagesQuery(prompt: "White cat with heterochromia sitting on the kitchen table", n: 1, size: "1024x1024")
        let result = try await openAI.images(query: query)
        XCTAssertFalse(result.data.isEmpty)
    }

    func testEmbeddings() async throws {
        let query = OpenAI.EmbeddingsQuery(model: .textSearchBabbadgeDoc, input: "The food was delicious and the waiter...")
        let result = try await openAI.embeddings(query: query)
        XCTAssertFalse(result.data.isEmpty)
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
        let request = try openAI.makeRequest(query: query, url: .completions, timeoutInterval: 60.0)
        let json = try JSONSerialization.jsonObject(with: request.httpBody!, options: []) as! [String: Any]
        XCTAssertEqual(json["temperature"] as? Double, 0.7)
    }
}
