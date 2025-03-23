import Foundation

public protocol OpenAIMiddleware: Sendable {
    func intercept(request: URLRequest) -> URLRequest
    func interceptStreamingData(_ data: Data) -> Data
    func intercept(response: URLResponse?, data: Data?) -> (response: URLResponse?, data: Data?)
}

public extension OpenAIMiddleware {
    func intercept(request: URLRequest) -> URLRequest { request }
    func interceptStreamingData(_ data: Data) -> Data { data }
    func intercept(response: URLResponse?, data: Data?) -> (response: URLResponse?, data: Data?) { (response, data) }
}
