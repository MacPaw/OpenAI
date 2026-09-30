import Foundation
import Testing
@testable import DemoChat
@testable import OpenAI

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
        "https://https://example.com/v1",
        "https://https:/example.com/v1",
        "HTTPS://HtTp:/example.com/v1",
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

@Test(arguments: ["https://example.com", "https://example.com/", "https://example.com///"])
func endpointSupportsRootMountedServers(baseURL: String) throws {
    let endpoint = try #require(APIEndpoint(baseURL: baseURL))
    #expect(endpoint.basePath.isEmpty)
}

@Test(arguments: ["https://example.com/v1/", "https://example.com/v1///", " \nhttps://example.com/v1/\t"])
func endpointNormalizesTrailingSlashesAndWhitespace(baseURL: String) throws {
    let endpoint = try #require(APIEndpoint(baseURL: baseURL))
    #expect(endpoint.basePath == "/v1")
}

@Test(arguments: [APIProvider.openAI, .gemini, .custom])
func configurationMapsEachProvider(provider: APIProvider) throws {
    let value = DemoAPIConfiguration(
        provider: provider,
        apiKey: " \ntest-token\t",
        customBaseURL: "http://localhost:8080/custom/",
        chatModel: " test-model "
    )
    let configuration = try #require(value.sdkConfiguration)
    let endpoint = try #require(APIEndpoint(baseURL: provider.defaultBaseURL ?? value.customBaseURL))
    #expect(configuration.token == "test-token")
    #expect(configuration.host == endpoint.host)
    #expect(configuration.scheme == endpoint.scheme)
    #expect(configuration.port == endpoint.port)
    #expect(configuration.basePath == endpoint.basePath)
    #expect(configuration.parsingOptions == provider.parsingOptions)
}

@Test(arguments: ["", " \n\t"])
func configurationRejectsEmptyCredentialsAndModels(empty: String) {
    #expect(DemoAPIConfiguration(apiKey: empty).sdkConfiguration == nil)
    #expect(DemoAPIConfiguration(apiKey: "test-token", chatModel: empty).sdkConfiguration == nil)
}

@Test func invalidCustomConfigurationDoesNotFallBackToOpenAI() {
    let value = DemoAPIConfiguration(provider: .custom, apiKey: "test-token", customBaseURL: "https:/bad", chatModel: "model")
    #expect(value.sdkConfiguration == nil)
}

@Test func providerSwitchClearsCredentialsAndRetainsCustomURL() {
    var value = DemoAPIConfiguration(apiKey: "openai-token", customBaseURL: "http://localhost:8080")
    value.selectProvider(.gemini)
    #expect(value.apiKey.isEmpty)
    #expect(value.chatModel.isEmpty)
    #expect(value.sdkConfiguration == nil)
    value.apiKey = "gemini-token"
    value.chatModel = "gemini-model"
    value.selectProvider(.custom)
    #expect(value.apiKey.isEmpty)
    #expect(value.chatModel.isEmpty)
    #expect(value.customBaseURL == "http://localhost:8080")
    value.selectProvider(.openAI)
    #expect(value.chatModel == Model.gpt5_6_luna)
    #expect(value.apiKey.isEmpty)
}

@Test func selectingSameProviderPreservesDraft() {
    var value = DemoAPIConfiguration(apiKey: "test-token")
    let original = value
    value.selectProvider(.openAI)
    #expect(value == original)
}

@Test func presetsIgnoreLegacyStoredURL() {
    let value = DemoAPIConfiguration.migrating(apiKey: "test-token", providerRawValue: "openAI", baseURL: "https://stale.example.com/v1")
    #expect(value.customBaseURL.isEmpty)
    #expect(value.sdkConfiguration?.host == "api.openai.com")
}

@Test func customLegacySettingsAreRetained() {
    let value = DemoAPIConfiguration.migrating(apiKey: "test-token", providerRawValue: "custom", baseURL: "http://localhost:8080/")
    #expect(value.customBaseURL == "http://localhost:8080/")
    #expect(value.chatModel.isEmpty)
    #expect(value.sdkConfiguration == nil)
}

@Test func configurationRoundTripsAsSingleValue() throws {
    let value = DemoAPIConfiguration(provider: .custom, apiKey: " token ", customBaseURL: " http://localhost:8080/ ", chatModel: " model ").normalized
    let decoded = try JSONDecoder().decode(DemoAPIConfiguration.self, from: JSONEncoder().encode(value))
    #expect(decoded == value)
    #expect(decoded.apiKey == "token")
    #expect(decoded.chatModel == "model")
    #expect(decoded.customBaseURL == "http://localhost:8080/")
}

@Test(arguments: ["https://example.com", "https://example.com/", "https://example.com///"])
func rootEndpointBuildsSingleSlashSDKPath(baseURL: String) throws {
    let endpoint = try #require(APIEndpoint(baseURL: baseURL))
    let components = URLComponents.components(perConfiguration: endpoint.configuration(token: "test-token"), path: "chat/completions")
    #expect(components.path == "/chat/completions")
}

@Test func hostOnlyEndpointDisplaysEffectiveHTTPSURL() throws {
    let endpoint = try #require(APIEndpoint(baseURL: "localhost:8080/custom/"))
    #expect(endpoint.baseURL == "https://localhost:8080/custom")
}
