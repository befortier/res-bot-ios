//
//  PostEndpoint.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// A protocol defining...
public protocol PostEndpoint<Body>: Endpoint {
    associatedtype Body: NetworkRequestBody
    var requestBody: Body? { get }
}

public typealias NetworkRequestBody = Sendable & Encodable
