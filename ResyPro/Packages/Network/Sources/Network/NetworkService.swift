//
//  NetworkService.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Interface for fetching and decoding network resources.
public protocol NetworkService: Sendable {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T
}

extension NetworkService {
    /// Fetches a resource but ignores the decoded response.
    public func fetch(from endpoint: Endpoint) async throws {
        _ = try await fetch(from: endpoint) as EmptyDecodable
    }
}
/// Production implementation of ``NetworkService``.
public struct NetworkServiceLive: NetworkService {
    private let client: any NetworkClient
    private let jsonDecoder: JSONDecoder

    public init(
        client: any NetworkClient,
        jsonDecoder: JSONDecoder
    ) {
        self.client = client
        self.jsonDecoder = jsonDecoder
    }

    public func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        guard let request = EndpointInterpreter.interpret(endpoint: endpoint) else {
            throw NetworkError.unknown
        }

        let (data, response): (Data, URLResponse) = try await client.data(for: request, delegate: nil)

        guard response.isHTTPSuccess else {
            switch (response as? HTTPURLResponse)?.statusCode {
            case 401, 403:
                throw NetworkError.unauthorized
            default:
                throw NetworkError.unknown
            }
        }

        return try jsonDecoder.decode(T.self, from: data)
    }
}
