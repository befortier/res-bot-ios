//
//  EnvironmentStore.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// Stores the currently selected environment for network calls.
public final actor EnvironmentStore {
  /// The active environment value.
  public private(set) var environment: Environment = .prod

  /// Updates the environment.
  /// - Parameter environment: The new environment value.
  public func update(_ environment: Environment) {
    self.environment = environment
  }
}
