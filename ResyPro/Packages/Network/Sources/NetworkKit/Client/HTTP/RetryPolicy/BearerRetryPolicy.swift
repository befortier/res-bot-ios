//
//  BearerRetryPolicy.swift
//  Network
//
//  Created by Ben Fortier on 5/30/25.
//

/// Refreshes the bearer token on the *first* 401/403, otherwise follows basic rules.
public struct BearerRetryPolicy: RetryPolicy {
    private let retryStatusSet: Set<Int> = [401, 403]
    private let refresher: any TokenRefreshing
    private let backoffBase = 200

    public init(refresher: any TokenRefreshing) { self.refresher = refresher }

    public func decision(
        for error: NetworkError,
        attempt: Int
    ) async throws -> RetryDecision {
        guard attempt == 0 else { return .fail }

        switch error {
        case .unauthorized:
            try await refresher.refreshToken()
            return .retry()
        case .serverError:
            return .retry(after: .milliseconds(backoffBase))
        default:
            return .fail
        }
    }
}
