//
//  ModelContainerProtocol.swift
//  ProjectFoundation
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
@preconcurrency import SwiftData

@MainActor
/// A protocol defined in the ProjectFoundation module.
public protocol ModelContainerProtocol: Sendable {
    var mainContext: ModelContext { get }
}

extension ModelContainer: ModelContainerProtocol, @unchecked Sendable {}
