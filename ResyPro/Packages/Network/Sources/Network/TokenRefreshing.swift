import Foundation

/// Abstraction for objects capable of refreshing bearer tokens.
public protocol TokenRefreshing: Sendable {
  /// Retrieves a new bearer token.
  func refreshToken() async throws
}
