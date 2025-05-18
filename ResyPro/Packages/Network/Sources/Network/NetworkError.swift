//
//  NetworkError.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// Errors thrown by ``NetworkService``.
public enum NetworkError: Error {
  /// An unknown error occurred.
  case unknown
  /// The request was unauthorized and may require a token refresh.
  case unauthorized
}
