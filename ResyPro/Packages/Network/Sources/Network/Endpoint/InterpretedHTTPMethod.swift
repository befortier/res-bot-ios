//
//  InterpretedHTTPMethod.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// String-based representation of HTTP methods.
public enum InterpretedHTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}
