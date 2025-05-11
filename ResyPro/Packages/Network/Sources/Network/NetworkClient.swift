//
//  NetworkClient.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

public protocol NetworkSession: Sendable {
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}
