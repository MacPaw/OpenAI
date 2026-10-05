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
        customBaseURL: "http://localhost:8080/custom/"
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
func configurationRejectsEmptyCredentials(empty: String) {
    #expect(DemoAPIConfiguration(apiKey: empty).sdkConfiguration == nil)
}

@Test func invalidCustomConfigurationDoesNotFallBackToOpenAI() {
    let value = DemoAPIConfiguration(provider: .custom, apiKey: "test-token", customBaseURL: "https:/bad")
    #expect(value.sdkConfiguration == nil)
}

@Test func providerSwitchClearsCredentialsAndRetainsCustomURL() {
    var value = DemoAPIConfiguration(apiKey: "openai-token", customBaseURL: "http://localhost:8080")
    value.selectProvider(.gemini)
    #expect(value.apiKey.isEmpty)
    #expect(value.sdkConfiguration == nil)
    value.apiKey = "gemini-token"
    value.selectProvider(.custom)
    #expect(value.apiKey.isEmpty)
    #expect(value.customBaseURL == "http://localhost:8080")
    value.selectProvider(.openAI)
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
    #expect(value.sdkConfiguration?.host == "localhost")
}

@Test func configurationDecodesDataSavedWithAChatModel() throws {
    let legacy = Data(#"{"provider":"gemini","apiKey":"token","customBaseURL":"","chatModel":"gemini-model"}"#.utf8)
    let value = try JSONDecoder().decode(DemoAPIConfiguration.self, from: legacy)
    #expect(value == DemoAPIConfiguration(provider: .gemini, apiKey: "token"))
}

@Test func configurationRoundTripsAsSingleValue() throws {
    let value = DemoAPIConfiguration(provider: .custom, apiKey: " token ", customBaseURL: " http://localhost:8080/ ").normalized
    let decoded = try JSONDecoder().decode(DemoAPIConfiguration.self, from: JSONEncoder().encode(value))
    #expect(decoded == value)
    #expect(decoded.apiKey == "token")
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

@Test func launchEnvironmentDefaultsToOpenAI() {
    let value = DemoLaunchEnvironment.configuration(from: ["DEMO_API_KEY": " sk-test \n", "GITHUB_TOKEN": "gh"])
    #expect(value == DemoAPIConfiguration(provider: .openAI, apiKey: "sk-test"))
    #expect(value?.sdkConfiguration?.host == "api.openai.com")
}

@Test(arguments: [("openAI", APIProvider.openAI), ("OPENAI", .openAI), ("gemini", .gemini), (" Gemini ", .gemini), ("custom", .custom)])
func launchEnvironmentSelectsTheProvider(name: String, expected: APIProvider) throws {
    let value = try #require(DemoLaunchEnvironment.configuration(from: [
        "DEMO_API_PROVIDER": name,
        "DEMO_API_KEY": "key",
        "DEMO_API_BASE_URL": "http://localhost:8080"
    ]))
    #expect(value.provider == expected)
    #expect(value.apiKey == "key")
    // The base URL only applies to the custom provider
    #expect(value.customBaseURL == (expected == .custom ? "http://localhost:8080" : ""))
}

@Test func launchEnvironmentCustomProviderWithoutAURLIsNotUsable() throws {
    let value = try #require(DemoLaunchEnvironment.configuration(from: ["DEMO_API_PROVIDER": "custom", "DEMO_API_KEY": "key"]))
    #expect(value.sdkConfiguration == nil)
}

@Test(arguments: [
    [:],
    ["DEMO_API_KEY": ""],
    ["DEMO_API_KEY": " \n\t"],
    ["DEMO_API_PROVIDER": "gemini"],
    ["DEMO_API_PROVIDER": "claude", "DEMO_API_KEY": "key"],
    ["OPENAI_API_KEY": "sk-test", "GITHUB_TOKEN": "gh"]
])
func launchEnvironmentIgnoresIncompleteOrUnknownConfigurations(environment: [String: String]) {
    #expect(DemoLaunchEnvironment.configuration(from: environment) == nil)
}

@Test func launchEnvironmentProvidesTheGitHubToken() {
    #expect(DemoLaunchEnvironment.githubToken(from: ["GITHUB_TOKEN": " ghp_test "]) == "ghp_test")
    #expect(DemoLaunchEnvironment.githubToken(from: ["GITHUB_TOKEN": ""]) == nil)
    #expect(DemoLaunchEnvironment.githubToken(from: ["DEMO_API_KEY": "key"]) == nil)
}

@Test(arguments: [
    ["DEMO_API_KEY": "key"],
    ["DEMO_API_PROVIDER": "claude"],
    ["DEMO_API_BASE_URL": "http://localhost:8080"],
    ["GITHUB_TOKEN": "ghp_test"],
    ["DEMO_API_KEY": "key", "GITHUB_TOKEN": "ghp_test"]
])
func launchEnvironmentProvidesSomething(environment: [String: String]) {
    #expect(DemoLaunchEnvironment.isProvided(in: environment))
}

@Test(arguments: [
    [:],
    ["DEMO_API_KEY": "", "GITHUB_TOKEN": " \n"],
    ["OPENAI_API_KEY": "sk-test", "HOME": "/tmp"]
])
func launchEnvironmentWithNothingKeepsSavedData(environment: [String: String]) {
    #expect(!DemoLaunchEnvironment.isProvided(in: environment))
}

