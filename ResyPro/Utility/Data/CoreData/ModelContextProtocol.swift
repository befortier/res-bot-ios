//
//  ModelContextProtocol.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/22/24.
//

import Foundation
@preconcurrency import SwiftData

@MainActor
protocol ModelContextProtocol: Sendable {
    var autosaveEnabled: Bool { get set }
    func insert<T>(_ model: T) where T : PersistentModel

    func save() throws
}


extension ModelContext: ModelContextProtocol {}
