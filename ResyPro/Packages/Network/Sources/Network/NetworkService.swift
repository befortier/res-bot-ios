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

/// Production implementation of ``NetworkService``.
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

    let data: Data =
      if let fixturesPath = endpoint.fixturesPath, false,
        let url = Bundle.module.url(forResource: fixturesPath, withExtension: "json")
      {
        try Data(contentsOf: url)
      } else {
        try await client.data(for: request, delegate: nil).0
      }

      return try jsonDecoder.decode(T.self, from: data)
  }
}
