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

    public func decision(for status: Int?, attempt: Int) async throws -> RetryDecision {
        guard
            let status = status,
            attempt == 0
        else { return .fail }

        if retryStatusSet.contains(status) {
            try await refresher.refreshToken()
            return .retry()
        }

        if 400..<500 ~= status {
            return .retry(after: .milliseconds(backoffBase))
        }

        return .fail
    }
}
