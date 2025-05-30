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
    func fetch<T: Decodable>(
        from endpoint: Endpoint,
        dateFormat: DateFormat?
    ) async throws -> T
}

extension NetworkService {
    /// Fetches a resource but ignores the decoded response.
    public func fetch(
        from endpoint: Endpoint,
        dateFormat: DateFormat?
    ) async throws {
        _ = try await fetch(from: endpoint, dateFormat: dateFormat) as EmptyDecodable
    }

    public func fetch(
        from endpoint: Endpoint
    ) async throws {
        _ = try await fetch(from: endpoint, dateFormat: nil) as EmptyDecodable
    }

    public func fetch<T: Decodable>(
        from endpoint: Endpoint
    ) async throws -> T {
        try await fetch(from: endpoint, dateFormat: nil)
    }
}
