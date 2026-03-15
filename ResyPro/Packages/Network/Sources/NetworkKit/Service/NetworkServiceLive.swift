//
//  NetworkServiceLive.swift
//  Network
//
//  Created by Ben Fortier on 5/30/25.
//

public import Foundation

/// Production implementation of ``NetworkService``.
public struct NetworkServiceLive: NetworkService {
    private let client: any NetworkClient
    private let baseJSONDecoder: JSONDecoder

    public init(
        client: any NetworkClient,
        jsonDecoder baseJSONDecoder: JSONDecoder
    ) {
        self.client = client
        self.baseJSONDecoder = baseJSONDecoder
    }

    public func fetch<T: Decodable>(
        from endpoint: Endpoint,
        dateFormat: DateFormat? = nil
    ) async throws -> T {
        guard let request = EndpointInterpreter.interpret(endpoint: endpoint) else {
            throw NetworkError.unknown
        }

        let (data, response): (Data, URLResponse) = try await client.data(for: request, delegate: nil)

        // Build a *fresh* decoder so concurrent calls don’t step on each other.
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = baseJSONDecoder.keyDecodingStrategy
        decoder.dataDecodingStrategy = baseJSONDecoder.dataDecodingStrategy
        decoder.nonConformingFloatDecodingStrategy =
        baseJSONDecoder.nonConformingFloatDecodingStrategy

        // Apply the per-call date rule if supplied.
        if let format = dateFormat {
            decoder.dateDecodingStrategy = format.decoderStrategy
        } else {
            decoder.dateDecodingStrategy = baseJSONDecoder.dateDecodingStrategy
        }

        return try decoder.decode(T.self, from: data)
    }
}
