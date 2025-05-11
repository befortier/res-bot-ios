//
//  EnvironmentStore.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
public import Combine

public final actor EnvironmentStore {
    var currentEnvironment: CurrentValueSubject<Environment, Never> = .init(.prod)
}
