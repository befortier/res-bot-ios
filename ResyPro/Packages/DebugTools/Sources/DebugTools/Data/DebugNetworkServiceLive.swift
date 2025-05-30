import Network
import Foundation

/// ``NetworkService`` implementation that records every request.
public struct DebugNetworkServiceLive: NetworkService {
    private let service: any NetworkService

    public init(
        client: any NetworkClient,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        service = NetworkServiceLive(
            client: RecordingNetworkClient(wrapped: client),
            jsonDecoder: jsonDecoder
        )
    }

    public func fetch<T: Decodable>(
        from endpoint: Endpoint,
        dateFormat: DateFormat?
    ) async throws -> T {
        try await service.fetch(from: endpoint, dateFormat: dateFormat)
    }
}
