import SwiftUI

extension EnvironmentValues {
    /// The ``NetworkService`` supplied through the environment.
    @Entry public var networkService: any NetworkService = FatalErrorNetworkService()
}

/// A fallback service that traps if accessed without being injected.
public struct FatalErrorNetworkService: NetworkService {
    public init() {}
    public func fetch<T>(from endpoint: Endpoint) async throws -> T where T : Decodable {
        fatalError("NetworkService not injected into environment")
    }
}
