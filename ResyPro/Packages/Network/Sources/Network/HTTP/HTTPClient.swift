import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Configuration containing tokens required for authenticated requests.
public struct HeaderConfiguration: Sendable {
    public typealias BearerToken = @Sendable () async -> String?
    public let userID: String
    /// The bearer token added to the `Authorization` header.
    public let bearerToken: BearerToken
    /// The token added to the `x-resy-auth-token` and `x-resy-universal-auth` headers.
    public let resyAuthToken: String?

    public init(
        userID: String,
        bearerToken: @escaping BearerToken,
        resyAuthToken: String?
    ) {
        self.userID = userID
        self.bearerToken = bearerToken
        self.resyAuthToken = resyAuthToken
    }
}

/// A lightweight HTTP client that forwards requests without modification.
public struct BasicHTTPClient: NetworkClient {
    private let session: any NetworkClient

    /// Creates a ``BasicHTTPClient`` using the provided session.
    /// - Parameter session: The underlying session used for requests.
    public init(session: any NetworkClient = URLSession.shared) {
        self.session = session
    }

    public func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        try await session.data(for: request, delegate: delegate)
    }
}



enum BearerHTTPClientError: Error {
    case noToken
}
