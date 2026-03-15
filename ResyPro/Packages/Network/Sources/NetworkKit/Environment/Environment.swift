//
//  Environment.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// Supported environments for network requests.
public enum DevelopmentEnvironment: Sendable {
  case stage
  case debug
  case prod
}
