import Foundation
import Testing
@testable import DemoChat
@testable import OpenAI

@MainActor
@Suite(.timeLimit(.minutes(1)))
struct ImageStoreTests {
    @Test(arguments: [ImagesQuery.Size._1024, ._1536x1024, ._1024x1536, .auto], [1, 10])
    func creationSendsExplicitModel(size: ImagesQuery.Size, n: Int) async throws {
        let mock = MockURL { _ in
            Data(#"{"created":1,"data":[{"url":"https://example.com/puppy.png"}]}"#.utf8)
        }
        defer { mock.remove() }
        let store = ImageStore(openAIClient: mock.makeClient())

        store.images(prompt: "A puppy", n: n, size: size)
        try await sleepUntil { !store.imagesQueryInProgress }

        let body = try #require(mock.lastBody)
        let json = try #require(JSONSerialization.jsonObject(with: body) as? [String: Any])
        #expect(json["model"] as? String == "gpt-image-1.5")
        #expect(json["prompt"] as? String == "A puppy")
        #expect(json["n"] as? Int == n)
        #expect(json["size"] as? String == size.rawValue)
        #expect(json["response_format"] == nil)
        #expect(store.images.first?.url == "https://example.com/puppy.png")
        #expect(store.imagesQueryError == nil)
    }

    @Test
    func failureIsVisible() async throws {
        let mock = MockURL { _ in
            Data(#"{"error":{"message":"Image generation rejected","type":"invalid_request_error"}}"#.utf8)
        }
        defer { mock.remove() }
        let store = ImageStore(openAIClient: mock.makeClient())

        store.images(prompt: "A puppy", n: 2, size: ._1024)
        try await sleepUntil { !store.imagesQueryInProgress }
        #expect(store.imagesQueryError?.localizedDescription == "Image generation rejected")
        #expect(store.images.isEmpty)
    }

    @Test
    func retryClearsErrorAndPublishesBase64Images() async throws {
        let png = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+ip1sAAAAASUVORK5CYII="
        let mock = MockURL { _ in
            Data(#"{"error":{"message":"Image generation rejected","type":"invalid_request_error"}}"#.utf8)
        }
        defer { mock.remove() }
        let store = ImageStore(openAIClient: mock.makeClient())

        store.images(prompt: "A puppy", n: 2, size: ._1024)
        try await sleepUntil { !store.imagesQueryInProgress }
        #expect(store.imagesQueryError != nil)

        mock.respond = { _ in
            try JSONSerialization.data(withJSONObject: [
                "created": 1, "data": [["b64_json": png], ["b64_json": png]]
            ])
        }

        store.images(prompt: "A puppy", n: 2, size: ._1024)
        #expect(store.imagesQueryError == nil)
        try await sleepUntil { !store.imagesQueryInProgress }
        #expect(store.imagesQueryError == nil)
        #expect(store.images.count == 2)
        #expect(store.images.allSatisfy { $0.hasBase64 && $0.url == nil && $0.cgImage?.width == 1 && $0.cgImage?.height == 1 })
    }

    @Test
    func cancellationEndsProgress() async throws {
        // Returning nil never answers the request, so it stays in flight until cancelled
        let mock = MockURL { _ in nil }
        defer { mock.remove() }
        let store = ImageStore(openAIClient: mock.makeClient())

        store.images(prompt: "A puppy", n: 2, size: ._1024)
        try await sleepUntil { mock.requestCount == 1 }
        #expect(store.imagesQueryInProgress)
        store.cancelImagesQuery()
        #expect(!store.imagesQueryInProgress)
        #expect(store.imagesQueryError == nil)
        #expect(store.images.isEmpty)
    }
}
