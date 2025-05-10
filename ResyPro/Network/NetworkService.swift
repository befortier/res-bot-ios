import Foundation

protocol NetworkService {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T
}

struct NetworkServiceLive: NetworkService {
    private let client: NetworkClient

    init(client: NetworkClient = NetworkClient(session: .shared)) {
        self.client = client
    }

    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        guard let request = EndpointInterpreter.interpret(endpoint: endpoint) else {
            throw NetworkError.unknown
        }
        let data = try await client.performRequest(request)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}