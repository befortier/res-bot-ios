//
//  ResyProApp.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import SwiftUI
import SwiftData
import User
import Venues
import ProjectFoundation
import Websockets
#if DEBUG
import DebugTools
#endif

@main
struct ResyProApp: App {
    @State private var websocketClient = URLSessionWebsocketClient.init()
    @Environment(\.scenePhase) private var scenePhase

    private let websocketURL = URL(string: "wss://backend.example.com/websocket")!

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.projectModelContainer, sharedModelContainer)
                .environment(\.websocketClient, websocketClient)
#if DEBUG
                .environment(\.networkHistoryStore, .shared)
#endif
                .task { await websocketClient.connect(url: websocketURL) }
                .onChange(of: scenePhase) { _, newPhase in
                    switch newPhase {
                    case .active:
                        Task { await websocketClient.connect(url: websocketURL) }
                    case .inactive, .background:
                        Task { await websocketClient.disconnect() }
                    @unknown default:
                        break
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }
}

