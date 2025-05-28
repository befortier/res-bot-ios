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

    private let tokenStore = TokenStoreFile()
    private var bootstrapUseCase: any BootstrapUseCase {
        BootstrapUseCaseLive(
            tokenStore: tokenStore,
            repositoryBuilder: { user in
                let service = BearerNetworkServiceComposer.make(
                    configuration: HeaderConfiguration(
                        user: user,
                        token: { await tokenStore.current?.token }
                    ),
                    tokenStore: tokenStore
                )
                let store = UserStoreLive(container: sharedModelContainer)
                return UserRepositoryLive(
                    networkService: service,
                    userStore: store
                )
            },
            logout: {
                await LogoutUseCaseLive(
                    container: sharedModelContainer,
                    websocketClient: websocketClient,
                    websocketURL: websocketURL
                )()
            }
        )
    }


  private let websocketURL = URL(string: "wss://resy-service.fly.dev:8081")!

  var body: some Scene {
    WindowGroup {
      RootView()
        .environment(\.projectModelContainer, sharedModelContainer)
        .environment(\.websocketClient, websocketClient)
        .environment(\.tokenStore, tokenStore)
        .environment(\.bootstrapUseCase, bootstrapUseCase)
        #if DEBUG
          .environmentObject(NetworkHistoryStore.shared)
        #endif
    }
    .modelContainer(sharedModelContainer)
  }
}
