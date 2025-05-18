import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Configuration containing tokens required for authenticated requests.
public struct ResyHeaderConfiguration: Sendable {
    public let userID: String
    /// The bearer token added to the `Authorization` header.
    public let bearerToken: String?
    /// The token added to the `x-resy-auth-token` and `x-resy-universal-auth` headers.
    public let resyAuthToken: String?

    public init(
        userID: String,
        bearerToken: String?,
        resyAuthToken: String?
    ) {
        self.userID = userID
        self.bearerToken = bearerToken
        self.resyAuthToken = resyAuthToken
    }
}

/// A lightweight HTTP client that forwards requests without modification.
public struct BasicHTTPClient: NetworkSession {
    private let session: any NetworkSession

    /// Creates a ``BasicHTTPClient`` using the provided session.
    /// - Parameter session: The underlying session used for requests.
    public init(session: any NetworkSession = URLSession.shared) {
        self.session = session
    }

    public func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        try await session.data(for: request, delegate: delegate)
    }
}

/// An HTTP client that attaches authentication headers to every request.
public struct BearerHTTPClient: NetworkSession {
    private let session: any NetworkSession
    private let configuration: ResyHeaderConfiguration

    /// Creates a ``BearerHTTPClient`` with the supplied configuration.
    /// - Parameters:
    ///   - configuration: Values used to populate authentication headers.
    ///   - session: The underlying session used for requests.
    public init(
        configuration: ResyHeaderConfiguration,
        session: any NetworkSession = URLSession.shared
    ) {
        self.configuration = configuration
        self.session = session
    }

    public func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        var request = request
        if let bearer = configuration.bearerToken {
            request.setValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")
        }
        if let resyToken = configuration.resyAuthToken {
            request.setValue(resyToken, forHTTPHeaderField: "x-resy-auth-token")
            request.setValue(resyToken, forHTTPHeaderField: "x-resy-universal-auth")
        }
        request.setValue(configuration.userID, forHTTPHeaderField: "user-id")

        return try await session.data(for: request, delegate: delegate)
    }
}
