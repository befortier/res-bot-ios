//
//  Endpoint.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// A protocol defining...
public protocol Endpoint {
    var baseURL: BaseURL { get }
    var path: String { get }
    var queryParameters: [String: String]? { get }
    var headers: [String: String]? { get }

    var fixturesPath: String? { get }
}

public extension Endpoint {
    var fixturesPath: String? { nil }
}
