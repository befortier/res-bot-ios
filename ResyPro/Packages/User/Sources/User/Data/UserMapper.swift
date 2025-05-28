import Foundation

/// Converts a ``UserDTO`` into a persistent ``User`` model.
public protocol UserMapper: Sendable {
    /// Creates a ``User`` from the given DTO.
    func map(dto: UserDTO) -> User
}

/// Default implementation of ``UserMapper``.
public struct UserMapperLive: UserMapper {
    public init() {}

    public func map(dto: UserDTO) -> User {
        User(
            id: dto.id,
            name: dto.name,
            email: dto.email,
            createdAt: dto.createdAt,
            profileImageURL: dto.profileImageURL,
            preferredLocation: dto.preferredLocation,
            resyAuthToken: dto.resyAuthToken,
            resyPaymentID: dto.resyPaymentID
        )
    }
}
