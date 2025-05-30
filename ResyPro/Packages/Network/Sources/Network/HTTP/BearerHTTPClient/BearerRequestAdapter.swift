//
//  BearerRequestAdapter.swift
//  Network
//
//  Created by Ben Fortier on 5/30/25.
//

public import Foundation

public protocol NetworkAdapter: Sendable {
    func adapt(_ request: URLRequest) async throws -> URLRequest
}

extension Sequence where Element == any NetworkAdapter {
    /// Serially applies each adapter; throws on the first failure.
    func adapt(_ req: URLRequest) async throws -> URLRequest {
        var r = req
        for ad in self { r = try await ad.adapt(r) }              // sequential
        return r
    }
}


/// Injects Auth-related headers on every outbound request.
public struct BearerRequestAdapter: NetworkAdapter {
    private let configuration: HeaderConfiguration

    public init(configuration: HeaderConfiguration) { self.configuration = configuration }

    /// Returns a *new* request with bearer / resy / user-id headers applied.
    public func adapt(_ request: URLRequest) async throws -> URLRequest {
        var r = request
        guard let bearer = await configuration.bearerToken() else {
            throw NetworkError.noToken
        }
        r.setValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")

        if let resy = configuration.resyAuthToken {
            r.setValue(resy, forHTTPHeaderField: "x-resy-auth-token")
            r.setValue(resy, forHTTPHeaderField: "x-resy-universal-auth")
        }
        r.setValue(configuration.userID, forHTTPHeaderField: "x-user-id")
        return r
    }
}
