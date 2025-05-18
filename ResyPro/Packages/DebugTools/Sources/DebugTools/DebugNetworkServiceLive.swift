import Network

/// ``NetworkService`` implementation that records every request.
public struct DebugNetworkServiceLive: NetworkService {
    private let service: any NetworkService

    public init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        service = NetworkServiceLive(
            client: RecordingNetworkSession(),
            jsonDecoder: jsonDecoder
        )
    }

    public func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        try await service.fetch(from: endpoint)
    }
}
