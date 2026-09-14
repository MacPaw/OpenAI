import Testing
@testable import DemoChat

@Test func providerPresetsUseExpectedBaseURLs() {
    #expect(APIProvider.openAI.defaultBaseURL == "https://api.openai.com/v1")
    #expect(
        APIProvider.gemini.defaultBaseURL
            == "https://generativelanguage.googleapis.com/v1beta/openai"
    )
    #expect(APIProvider.custom.defaultBaseURL == nil)
    #expect(APIProvider.openAI.parsingOptions.isEmpty)
    #expect(APIProvider.gemini.parsingOptions == .relaxed)
    #expect(APIProvider.custom.parsingOptions == .relaxed)
}

@Test func endpointParsesHTTPSBaseURL() throws {
    let endpoint = try #require(APIEndpoint(baseURL: "https://example.com/openai/v1"))

    #expect(endpoint.scheme == "https")
    #expect(endpoint.host == "example.com")
    #expect(endpoint.port == 443)
    #expect(endpoint.basePath == "/openai/v1")
}

@Test func endpointSupportsHostOnlyInput() throws {
    let endpoint = try #require(APIEndpoint(baseURL: "example.com/v1"))

    #expect(endpoint.scheme == "https")
    #expect(endpoint.host == "example.com")
    #expect(endpoint.port == 443)
    #expect(endpoint.basePath == "/v1")
}

@Test func endpointSupportsLocalHTTPPort() throws {
    let endpoint = try #require(APIEndpoint(baseURL: "http://localhost:8080/custom"))

    #expect(endpoint.scheme == "http")
    #expect(endpoint.host == "localhost")
    #expect(endpoint.port == 8080)
    #expect(endpoint.basePath == "/custom")
}

@Test func endpointBuildsOpenAIConfiguration() throws {
    let endpoint = try #require(APIEndpoint(baseURL: "http://localhost:8080/custom"))
    let configuration = endpoint.configuration(
        token: "test-token",
        parsingOptions: .relaxed
    )

    #expect(configuration.token == "test-token")
    #expect(configuration.scheme == "http")
    #expect(configuration.host == "localhost")
    #expect(configuration.port == 8080)
    #expect(configuration.basePath == "/custom")
    #expect(configuration.parsingOptions == .relaxed)
}

@Test(arguments: [0, 65_536, 99_999])
func endpointRejectsOutOfRangePorts(port: Int) {
    #expect(APIEndpoint(baseURL: "https://example.com:\(port)/v1") == nil)
}

@Test func endpointAcceptsMaximumPort() throws {
    let endpoint = try #require(APIEndpoint(baseURL: "https://example.com:65535/v1"))

    #expect(endpoint.port == 65_535)
}

@Test(
    arguments: [
        "",
        "ftp://example.com/v1",
        "https://example.com:invalid/v1",
        "https://user:password@example.com/v1",
        "https://example.com/v1?key=value",
        "https://example.com/v1#fragment",
    ]
)
func endpointRejectsUnsupportedBaseURLs(baseURL: String) {
    #expect(APIEndpoint(baseURL: baseURL) == nil)
}
