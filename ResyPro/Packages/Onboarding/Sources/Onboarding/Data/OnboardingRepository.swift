//
//  OnboardingRepository.swift
//  Onboarding
//
//  Created by Ben Fortier on 5/28/25.
//

import Foundation
import Network
import ProjectFoundation
import User
import Authentication

/// Handles user authentication and token persistence.
public protocol OnboardingRepository: Sendable {
    /// Registers a new user.
    func signUp(firstName: String, lastName: String, phoneNumber: String) async throws -> AuthResponse
    /// Logs an existing user in.
    func login(phoneNumber: String) async throws -> AuthResponse
}

/// Live implementation using ``NetworkService``.
public struct OnboardingRepositoryLive: OnboardingRepository {
    private let networkService: any NetworkService
    private let tokenStore: TokenStore

    public init(
        networkService: any NetworkService,
        tokenStore: TokenStore
    ) {
        self.networkService = networkService
        self.tokenStore = tokenStore
    }

    public func signUp(
        firstName: String,
        lastName: String,
        phoneNumber: String
    ) async throws -> AuthResponse {
        let response: AuthResponse = try await networkService.fetch(
            from: SignUpEndpoint(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        )
        await storeTokens(from: response)
        return response
    }

    public func login(
        phoneNumber: String
    ) async throws -> AuthResponse {
        let response: AuthResponse = try await networkService.fetch(
            from: LoginEndpoint(phoneNumber: phoneNumber)
        )
        await storeTokens(from: response)
        return response
    }

    private func storeTokens(
        from response: AuthResponse
    ) async {
        let pair = TokenPair(token: response.token, refreshToken: response.refreshToken)
        await tokenStore.setCurrent(to: pair)
    }
}
