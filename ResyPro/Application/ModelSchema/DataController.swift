//
//  DataController.swift
//  ResyPro
//
//  Created by Ben Fortier on 5/17/25.
//

import SwiftData
import User
import Venues

private let modelSchema = Schema([
    User.self,
    ResyConfig.self,
    SchedueledReservation.self,
    Venue.self
])

@MainActor
var sharedModelContainer: ModelContainer = {
    let modelConfiguration = ModelConfiguration(schema: modelSchema, isStoredInMemoryOnly: false)

    do {
        var modelContainer = try ModelContainer(for: modelSchema, configurations: [modelConfiguration])
        modelContainer.mainContext.autosaveEnabled = false
        return modelContainer
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()


@MainActor
class DataController {
    static var previewContainer: ModelContainer = {
        do {
            let modelConfiguration = ModelConfiguration(schema: modelSchema, isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: modelSchema, configurations: [modelConfiguration])
            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
