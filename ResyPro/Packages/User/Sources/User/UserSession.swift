//
//  UserSession.swift
//  User
//
//  Created by Ben Fortier on 5/28/25.
//

public import Authentication
public import SwiftUI

/// Runtime session object shared via `.environmentObject`.
/// Uses the Swift 5.10 `@Observable` macro so SwiftUI can diff sub-properties.
@Observable public final class UserSession: Identifiable, @unchecked Sendable {

    // MARK: – Identity & Init

    public let id = UUID()

    public private(set) var user: User
    public private(set) var token: TokenPair

    public init(user: User, token: TokenPair) {
        self.user  = user
        self.token = token
    }

    // MARK: – Mutations

    /// Called by `SessionRepository` when a token refresh succeeds.
    public func updateToken(_ newToken: TokenPair) {
        guard newToken != token else { return }
        token = newToken
    }

    // TODO: Check if this is Sendable. Also need to fill this in.
    /// Convenience for profile edits that come back from the API.
    public func patchUser(_ patch: (inout User) -> Void) {
        patch(&user)
    }
}
