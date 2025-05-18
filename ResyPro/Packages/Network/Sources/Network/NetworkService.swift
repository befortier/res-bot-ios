//
//  NetworkService.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

public protocol NetworkService: Sendable {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T
}

/// A struct representing...
public struct NetworkServiceLive: NetworkService {
    private let client: any NetworkSession
    private let jsonDecoder: JSONDecoder

    public init(
        client: any NetworkSession = URLSession.shared,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.client = client
        self.jsonDecoder = jsonDecoder
    }

    public func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        guard let request = EndpointInterpreter.interpret(endpoint: endpoint) else {
            throw NetworkError.unknown
        }

        let data: Data = if let fixturesPath = endpoint.fixturesPath, let url = Bundle.module.url(forResource: fixturesPath, withExtension: "json") {
            try Data(contentsOf: url)
        } else {
            try await client.data(for: request, delegate: nil).0
        }

        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
