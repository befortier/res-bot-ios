//
//  InterpretedEndpoint.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

/// A fully constructed request derived from an ``Endpoint``.
public struct InterpretedEndpoint {
  let urlRequest: URLRequest
}
