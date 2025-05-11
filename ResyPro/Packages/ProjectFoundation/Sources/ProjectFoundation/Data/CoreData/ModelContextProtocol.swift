//
//  ModelContextProtocol.swift
//  ProjectFoundation
//
//  Created by Ben Fortier on 6/19/24.
//


import Foundation
@preconcurrency import SwiftData

@MainActor
/// A protocol defined in the ProjectFoundation module.
public protocol ModelContextProtocol: Sendable {
    var autosaveEnabled: Bool { get set }
    func insert<T>(_ model: T) where T : PersistentModel

    func save() throws
}


extension ModelContext: ModelContextProtocol, @unchecked Sendable {}
