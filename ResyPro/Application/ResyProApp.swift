//
//  ResyProApp.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import SwiftUI
import SwiftData

@main
struct ResyProApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(sharedModelContainer)
    }
}

private let modelSchema = Schema([
    User.self,
    ResyConfig.self,
    SchedueledReservation.self,
    Venue.self
])

var sharedModelContainer: ModelContainer = {
    let modelConfiguration = ModelConfiguration(schema: modelSchema, isStoredInMemoryOnly: false)

    do {
        return try ModelContainer(for: modelSchema, configurations: [modelConfiguration])
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

