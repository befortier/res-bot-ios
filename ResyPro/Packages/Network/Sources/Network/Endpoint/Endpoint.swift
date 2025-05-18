//
//  Endpoint.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// Defines the information needed to build a network request.
public protocol Endpoint {
  var baseURL: BaseURL { get }
  var path: String { get }
  var queryParameters: [String: String]? { get }
  var headers: [String: String]? { get }

  var fixturesPath: String? { get }
}

extension Endpoint {
  public var fixturesPath: String? { nil }
}
