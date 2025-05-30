//
//  TokenRefresher.swift
//  User
//
//  Created by Ben Fortier on 5/30/25.
//

import Network
import Foundation
import Authentication

public struct TokenRefresher: TokenRefreshing {
    private let authTokenRepository: any AuthenticationRepository
    private let userSession: UserSession

    public init(
        authTokenRepository: any AuthenticationRepository,
        userSession: UserSession
    ) {
        self.authTokenRepository = authTokenRepository
        self.userSession = userSession
    }

    public func refreshToken() async throws {
        let tokenPair = try await authTokenRepository.refresh()
        userSession.updateToken(tokenPair)
    }
}
