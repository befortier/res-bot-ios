import Authentication
import Network
import User
import ProjectFoundation
import os

/// Bootstraps the application by validating authentication state.
public protocol BootstrapUseCase: Sendable {
    /// Performs the bootstrap process for the provided user.
    func callAsFunction(user: User?) async throws -> UserSession?
}

/// Default implementation that fetches the user when a token is present.
public struct BootstrapUseCaseLive: BootstrapUseCase {
    private let tokenStore: TokenStore
    private let userRepository: @Sendable (UserSession) -> any UserRepository
    private let logout: @Sendable () async -> Void
    private let logger = Logger(subsystem: "com.resy.pro", category: "Bootstrap")

    public init(
        tokenStore: TokenStore,
        userRepository: @escaping @Sendable (UserSession) -> any UserRepository,
        logout: @escaping @Sendable () async -> Void
    ) {
        self.tokenStore = tokenStore
        self.userRepository = userRepository
        self.logout = logout
    }

    public func callAsFunction(user: User?) async throws  -> UserSession? {
        guard
            let tokenPair = await tokenStore.current,
            let user
        else {
            await logout()
            return nil
        }

        do {
            let userSession = UserSession(
                user: user,
                token: tokenPair
            )
            _ = try await userRepository(userSession).refreshUser(id: user.id)
            return userSession
        } catch NetworkError.unauthorized {
            await logout()
            return nil
        } catch let NetworkError.clientError(errorCode) where errorCode == 404 {
            await logout()
            return nil
        } catch {
            logger.error("Bootstrap failed: \(error, privacy: .public)")
            throw error
        }
    }
}
