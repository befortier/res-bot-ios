//
//  NetworkError.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// Errors thrown by ``NetworkService``.
/// Canonical network errors understood by the retry policy.
public enum NetworkError: Error, Equatable {
    case unauthorized          // 401 / 403
    case clientError(Int)      // other 4xx
    case serverError(Int)      // 5xx
    case transport(URLError)   // connectivity / TLS, etc.
    case noToken
    case unknown
}
