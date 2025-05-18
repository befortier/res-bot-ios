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

  var body: some Scene {
    WindowGroup {
      RootView()
        .environment(\.projectModelContainer, sharedModelContainer)
        .environment(\.websocketClient, websocketClient)
        .environment(\.tokenStore, TokenStoreFile())
        #if DEBUG
          .environmentObject(NetworkHistoryStore.shared)
        #endif
    }
    .modelContainer(sharedModelContainer)
  }
}
