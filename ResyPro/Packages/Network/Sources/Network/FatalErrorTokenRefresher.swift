import Foundation

/// A ``TokenRefreshing`` implementation that triggers a runtime error when used.
public struct FatalErrorTokenRefresher: TokenRefreshing {
  public init() {}
  public func refreshToken() async throws {
    fatalError("TokenRefresher not provided")
  }
}
