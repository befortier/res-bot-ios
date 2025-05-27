//
//  BearerHTTPClient.swift
//  Network
//
//  Created by Ben Fortier on 5/26/25.
//

import Foundation

/// An HTTP client that attaches authentication headers to every request.
public struct BearerHTTPClient: NetworkClient {
    private let session: any NetworkClient
    private let configuration: HeaderConfiguration
    private let tokenRefresher: any TokenRefreshing

    /// Creates a ``BearerHTTPClient`` with the supplied configuration.
    /// - Parameters:
    ///   - configuration: Values used to populate authentication headers.
    ///   - session: The underlying session used for requests.
    public init(
        configuration: HeaderConfiguration,
        session: any NetworkClient = URLSession.shared,
        tokenRefresher: any TokenRefreshing,
    ) {
        self.configuration = configuration
        self.session = session
        self.tokenRefresher = tokenRefresher
    }

    public func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        do {
            return try await executeBearerRequest(request, delegate: delegate)
        } catch NetworkError.unauthorized {
            try await tokenRefresher.refreshToken()
            return try await executeBearerRequest(request, delegate: delegate)
        }
    }

    private func executeBearerRequest(_ request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        var request = request
        guard let bearer = await configuration.bearerToken() else {
            throw BearerHTTPClientError.noToken
        }
        request.setValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")
        if let resyToken = configuration.resyAuthToken {
            request.setValue(resyToken, forHTTPHeaderField: "x-resy-auth-token")
            request.setValue(resyToken, forHTTPHeaderField: "x-resy-universal-auth")
        }
        request.setValue(configuration.userID, forHTTPHeaderField: "x-user-id")

        return try await session.data(for: request, delegate: delegate)
    }
}
