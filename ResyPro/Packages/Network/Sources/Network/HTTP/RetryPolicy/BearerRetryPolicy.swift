//
//  BearerRetryPolicy.swift
//  Network
//
//  Created by Ben Fortier on 5/30/25.
//


/// Refreshes the bearer token on the *first* 401/403, otherwise follows basic rules.
public struct BearerRetryPolicy: RetryPolicy {
    private let refresher: any TokenRefreshing
    private let backoffBase = 200               // ms

    public init(refresher: any TokenRefreshing) { self.refresher = refresher }

    public func decision(for status: Int?, attempt: Int) async throws -> RetryDecision {
        guard let status = status else { return .fail }           // no HTTP code

        switch status {
        case 401, 403 where attempt == 0:
            try await refresher.refreshToken()                    // ⬅️ side-effect!
            return .retry()                                       // immediate retry
        case 400..<500 where attempt == 0:
            return .retry(after: .milliseconds(backoffBase))
        default:
            return .fail
        }
    }
}
