//
//  RetryDirective.swift
//  Network
//
//  Created by Ben Fortier on 5/30/25.
//

import Foundation

/// Possible actions after inspecting an HTTP status code.
/// What the policy wants the caller to do.
public enum RetryDecision {
    /// Retry immediately (optionally after `delay`).
    case retry(after: Duration = .zero)
    /// Give up and surface the error.
    case fail
}

/// A strategy object that both *decides* and can run pre-retry side-effects
/// (e.g. token refresh).  That keeps HTTPClient blissfully unaware of auth.
public protocol RetryPolicy: Sendable {
    func decision(
        for status: Int?,                // nil ⇒ transport layer
        attempt: Int
    ) async throws -> RetryDecision
}
