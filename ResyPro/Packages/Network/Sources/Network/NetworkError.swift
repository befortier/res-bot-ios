//
//  NetworkError.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// An enum representing...
public enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case unknown
}