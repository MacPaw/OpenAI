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

@Test func endpointSupportsHostOnlyInputWithPort() throws {
    let endpoint = try #require(APIEndpoint(baseURL: "localhost:8080/custom"))

    #expect(endpoint.scheme == "https")
    #expect(endpoint.host == "localhost")
    #expect(endpoint.port == 8080)
    #expect(endpoint.basePath == "/custom")
}

@Test func endpointSupportsUppercaseHTTPS() throws {
    let endpoint = try #require(APIEndpoint(baseURL: "HTTPS://example.com/v1"))

    #expect(endpoint.scheme == "https")
    #expect(endpoint.host == "example.com")
    #expect(endpoint.port == 443)
}

@Test func endpointSupportsLocalHTTPPort() throws {
    let endpoint = try #require(APIEndpoint(baseURL: "http://localhost:8080/custom"))

    #expect(endpoint.scheme == "http")
    #expect(endpoint.host == "localhost")
    #expect(endpoint.port == 8080)
    #expect(endpoint.basePath == "/custom")
}

@Test(arguments: ["localhost", "LOCALHOST", "127.0.0.1", "127.255.255.255", "[::1]"])
func endpointSupportsLoopbackHTTP(host: String) throws {
    let endpoint = try #require(APIEndpoint(baseURL: "http://\(host):8080/custom"))

    #expect(endpoint.scheme == "http")
    #expect(endpoint.host == host)
    #expect(endpoint.port == 8080)
    #expect(endpoint.basePath == "/custom")
}

@Test(
    arguments: [
        "http://example.com/v1",
        "http://192.168.1.10:8080/v1",
        "http://localhost.example.com/v1",
        "http://example.localhost/v1",
        "http://127.0.0.1.example.com/v1",
        "http://128.0.0.1/v1",
        "http://127.0.0.256/v1",
        "http://127.0.0.01/v1",
        "http://127.+0.0.1/v1",
        "http://127.0..1/v1",
        "http://127.1/v1",
        "http://0x7f000001/v1",
        "http://[::]/v1",
        "http://[2001:db8::1]/v1",
    ]
)
func endpointRejectsNonLoopbackHTTP(baseURL: String) {
    #expect(APIEndpoint(baseURL: baseURL) == nil)
}

@Test(
    arguments: [
        "http:example.com/v1",
        "http:/example.com/v1",
        "https:example.com/v1",
        "https:/example.com/v1",
        "HTTPS:/example.com/v1",
        "HtTp:/localhost:8080/v1",
    ]
)
func endpointRejectsMalformedHTTPSchemes(baseURL: String) {
    #expect(APIEndpoint(baseURL: baseURL) == nil)
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
