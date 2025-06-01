//
//  BasicRetryPolicy.swift
//  Network
//
//  Created by Ben Fortier on 5/30/25.
//

/// Retries once for *any* 4xx except 401/403. Never refreshes.
public struct BasicRetryPolicy: RetryPolicy {
    private let backoffBase = 200 // ms

    public init() {}

    public func decision(
        for error: NetworkError,
        attempt: Int
    ) async throws -> RetryDecision {
        switch error {
        case .serverError:
            .retry(after: .milliseconds(backoffBase))
        default:
            .fail
        }
    }
}
