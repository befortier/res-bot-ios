import Foundation
import Network
import ProjectFoundation

/// Handles user authentication and token persistence.
public protocol AuthenticationRepository: Sendable {
    /// Refreshes the access token using the stored refresh token.
    func refresh() async throws -> TokenPair
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

    public func refresh() async throws -> TokenPair {
        guard let refreshToken = await tokenStore.current?.refreshToken else { throw NetworkError.unknown }
        let response: RefreshTokenResponse = try await networkService.fetch(
            from: RefreshEndpoint(
                refreshToken: refreshToken
            )
        )
        let pair = TokenPair(token: response.token, refreshToken: refreshToken)
        await tokenStore.setCurrent(to: pair)
        return pair
    }
}

public typealias TokenStore = any DataStore<TokenPair?>

fileprivate struct RefreshTokenResponse: Codable {
    let token: String
}

