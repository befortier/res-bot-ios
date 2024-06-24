//
//  ModelContextProtocol.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/22/24.
//

import Foundation
import SwiftData

@MainActor
protocol ModelContextProtocol {
    func insert<T>(_ model: T) where T : PersistentModel
}


extension ModelContext: ModelContextProtocol {}
