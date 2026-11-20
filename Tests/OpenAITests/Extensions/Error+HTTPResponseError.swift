import Foundation
@testable import OpenAI

extension Error {
    /// The payload of `OpenAIError.httpStatusError`, or `nil` for any other error.
    var httpResponseError: HTTPResponseError? {
        guard case .httpStatusError(let httpError)? = self as? OpenAIError else {
            return nil
        }
        return httpError
    }
}
