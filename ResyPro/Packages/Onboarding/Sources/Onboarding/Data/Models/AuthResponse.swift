import Foundation
import User

/// Response returned by the backend after authentication operations.
public struct AuthResponse: Codable, Sendable {
    /// The authenticated user information.
    public let user: UserInfo
    /// Short-lived token for authenticated requests.
    public let token: String
    /// Refresh token used to obtain a new access token.
    public let refreshToken: String
}
