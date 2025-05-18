import Foundation
import Network
import ProjectFoundation
import User

/// Handles user authentication and token persistence.
public protocol AuthenticationRepository: Sendable {
    /// Registers a new user.
    func signUp(firstName: String, lastName: String, phoneNumber: String) async throws -> UserInfo
    /// Logs an existing user in.
    func login(phoneNumber: String) async throws -> UserInfo
    /// Refreshes the access token using the stored refresh token.
    func refresh() async throws -> String
}

/// Live implementation using ``NetworkService``.
public struct AuthenticationRepositoryLive: AuthenticationRepository {
    private let networkService: any NetworkService
    private let tokenStore: TokenStore

    public init(
        networkService: any NetworkService,
        tokenStore: TokenStore = TokenStoreFile()
    ) {
        self.networkService = networkService
        self.tokenStore = tokenStore
    }

    public func signUp(firstName: String, lastName: String, phoneNumber: String) async throws -> UserInfo
    {
        let response: AuthResponse = try await networkService.fetch(
            from: SignUpEndpoint(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        )
        await storeTokens(from: response)
        return response.user
    }

    public func login(phoneNumber: String) async throws -> UserInfo {
        let response: AuthResponse = try await networkService.fetch(
            from: LoginEndpoint(phoneNumber: phoneNumber)
        )
        await storeTokens(from: response)
        return response.user
    }

    public func refresh() async throws -> String {
        guard let refreshToken = await tokenStore.current?.refreshToken else { throw NetworkError.unknown }
        struct Response: Codable { let token: String }
        let response: Response = try await networkService.fetch(
            from: RefreshEndpoint(refreshToken: refreshToken)
        )
        let pair = TokenPair(token: response.token, refreshToken: refreshToken)
        await tokenStore.setCurrent(to: pair)
        return response.token
    }

    private func storeTokens(from response: AuthResponse) async {
        let pair = TokenPair(token: response.token, refreshToken: response.refreshToken)
        await tokenStore.setCurrent(to: pair)
    }
}

public typealias TokenStore = any DataStore<TokenPair>

extension AuthenticationRepositoryLive: TokenRefreshing {
    public func refreshToken() async throws -> String {
        try await refresh()
    }
}
