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

    public func decision(for status: Int?, attempt: Int) async throws -> RetryDecision {
        guard let status = status else { return .fail }
        switch status {
        case 400..<500 where status != 401 && status != 403 && attempt == 0:
            return .retry(after: .milliseconds(backoffBase))
        default:
            return .fail
        }
    }
}
