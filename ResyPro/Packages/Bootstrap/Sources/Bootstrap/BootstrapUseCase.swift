import Authentication
import Network
import User
import ProjectFoundation
import os

/// Bootstraps the application by validating authentication state.
public protocol BootstrapUseCase: Sendable {
    /// Performs the bootstrap process for the provided user.
    func callAsFunction(user: User?) async
}

/// Default implementation that fetches the user when a token is present.
public struct BootstrapUseCaseLive: BootstrapUseCase {
    private let tokenStore: TokenStore
    private let repositoryBuilder: (User) -> any UserRepository
    private let logout: @Sendable () async -> Void
    private let logger = Logger(subsystem: "com.resy.pro", category: "Bootstrap")

    public init(
        tokenStore: TokenStore,
        repositoryBuilder: @escaping (User) -> any UserRepository,
        logout: @escaping @Sendable () async -> Void
    ) {
        self.tokenStore = tokenStore
        self.repositoryBuilder = repositoryBuilder
        self.logout = logout
    }

    public func callAsFunction(user: User?) async {
        guard await tokenStore.current != nil, let user else {
            await logout()
            return
        }

        let repository = repositoryBuilder(user)
        do {
            _ = try await repository.refreshUser(id: user.id)
        } catch NetworkError.unauthorized {
            await logout()
        } catch {
            logger.error("Bootstrap failed: \(error, privacy: .public)")
        }
    }
}
