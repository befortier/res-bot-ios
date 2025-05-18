import Network
import Foundation

/// ``NetworkService`` implementation that records every request.
public struct DebugNetworkServiceLive: NetworkService {
    private let service: any NetworkService

    public init(
        client: any NetworkSession,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        service = NetworkServiceLive(
            client: RecordingNetworkSession(wrapped: client),
            jsonDecoder: jsonDecoder
        )
    }

    public func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        try await service.fetch(from: endpoint)
    }
}
