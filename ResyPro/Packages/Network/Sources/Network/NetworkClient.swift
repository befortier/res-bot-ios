//
//  NetworkClient.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

/// Abstraction over ``URLSession`` for testability.
public protocol NetworkClient: Sendable {
  /// Performs a URL request and returns the resulting data and response.
  func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (
    Data, URLResponse
  )
}

extension URLSession: NetworkClient {}
