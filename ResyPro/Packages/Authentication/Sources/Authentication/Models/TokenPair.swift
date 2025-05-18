//
//  TokenPair.swift
//  Authentication
//
//  Created by OpenAI on 6/19/24.
//

import Foundation

/// Represents a short-lived token and associated refresh token.
public struct TokenPair: Codable, Hashable, Sendable {
    /// The access token used for authenticated requests.
    public let token: String
    /// The refresh token used to obtain a new access token.
    public let refreshToken: String

    public init(token: String, refreshToken: String) {
        self.token = token
        self.refreshToken = refreshToken
    }
}
