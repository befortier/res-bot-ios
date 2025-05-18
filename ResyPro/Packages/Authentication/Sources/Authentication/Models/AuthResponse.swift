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

public struct UserInfo: Codable, Sendable {
    public let userID: String
    public let firstName: String
    public let lastName: String
}

extension User {
    /// Creates a ``User`` from backend user info.
    init(info: UserInfo) {
        self.init(
            id: info.userID,
            name: "\(info.firstName) \(info.lastName)",
            email: "",
            createdAt: Date()
        )
    }
}
