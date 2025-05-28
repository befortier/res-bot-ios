import Foundation

/// Representation of a user returned from the backend API.
public struct UserDTO: Codable, Sendable, Equatable {
    /// Unique identifier for the user.
    public let id: String
    /// Full name of the user.
    public let name: String
    /// Email address.
    public let email: String
    /// Account creation date.
    public let createdAt: Date
    /// Optional profile image URL.
    public let profileImageURL: URL?
    /// Preferred location of the user.
    public let preferredLocation: String
    /// Optional Resy authentication token.
    public let resyAuthToken: String?
    /// Optional payment identifier.
    public let resyPaymentID: String?
}
