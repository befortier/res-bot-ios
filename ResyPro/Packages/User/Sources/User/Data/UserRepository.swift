import Foundation
import Network
import ProjectFoundation

/// Responsible for retrieving user data from the backend and storing it locally.
public protocol UserRepository: Sendable {
    /// Fetches the user with the provided identifier and persists it.
    func refreshUser(id: String) async throws
}

/// Default ``UserRepository`` implementation.
public struct UserRepositoryLive: UserRepository {
    private let networkService: any NetworkService
    private let userStore: any UserStore
    private let mapper: any UserMapper

    public init(
        networkService: any NetworkService,
        userStore: any UserStore,
        mapper: any UserMapper = UserMapperLive()
    ) {
        self.networkService = networkService
        self.userStore = userStore
        self.mapper = mapper
    }

    public func refreshUser(id: String) async throws{
        let dto: UserDTO = try await networkService.fetch(from: GetUserEndpoint(userID: id))
        try await MainActor.run {
            let user = mapper.map(dto: dto)
            try userStore.save(user)
        }
    }
}
