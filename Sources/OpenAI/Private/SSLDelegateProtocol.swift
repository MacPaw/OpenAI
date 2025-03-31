import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public protocol SSLDelegateProtocol: Sendable {
    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    )
}
