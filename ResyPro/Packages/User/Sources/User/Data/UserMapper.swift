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
            id: dto.userID,
            name: dto.firstName + " " + dto.lastName,
            email: "STUB",
            createdAt: .now,
            profileImageURL: nil,
            preferredLocation: "STUB",
            resyAuthToken: .stubResyToken,
            resyPaymentID: "TBD"
        )
    }
}
