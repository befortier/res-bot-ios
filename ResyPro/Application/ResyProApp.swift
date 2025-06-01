//
//  ResyProApp.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Authentication
import ProjectFoundation
import SwiftData
import SwiftUI
import User
import Venues
import Websockets
import Bootstrap

#if DEBUG
import DebugTools
#endif

@main
struct ResyProApp: App {
#if DEBUG
    @State private var websocketClient = RecordingWebsocketClient(
        wrapped: URLSessionWebsocketClient()
    )
#else
    @State private var websocketClient = URLSessionWebsocketClient.init()
#endif

    private let websocketURL = URL(string: "wss://resy-service.fly.dev:8081")!
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView(
                bootStrap: BootstrapUseCaseComposer.make(
                    modelContainer: sharedModelContainer,
                    websocketClient: websocketClient
                )
            )
            .setModelContainer(sharedModelContainer)
        }
        .environment(\.websocketClient, websocketClient)
#if DEBUG
        .environmentObject(NetworkHistoryStore.shared)
#endif
    }
}
