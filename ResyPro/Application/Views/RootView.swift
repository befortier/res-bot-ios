//
//  RootView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData
import SwiftUI
import User
import Bootstrap
import Websockets
import Onboarding

@MainActor
struct RootView: View {
    enum ViewState {
        case loading
        case mainTab(UserSession)
        case unauthenticated
        case failedToLoad
    }

    @Environment(\.websocketClient) var websocketClient
    @Query private var users: [User]
    let bootStrap: any BootstrapUseCase
    @State var state: ViewState = .loading

    var body: some View {
        Group {
            switch state {
            case .loading:
                ProgressView()
                    .task { await checkForBootstrap(user: users.first) }
                    .onChange(of: users) { _, users in
                        Task { await checkForBootstrap(user: users.first) }
                    }
            case let .mainTab(userSession):
                MainTabView()
                    .environment(userSession)
            case .unauthenticated:
                OnboardingView(networkService: BasicNetworkServiceComposer.make()) { userSession in
                    self.state = .mainTab(userSession)
                }
            case .failedToLoad:
                Text("Error")
            }
        }
        .maintainWebsocketConnection(user: users.first)
        .navigationViewStyle(.stack)
        .observeForDebug()
        .onChange(of: users) { previousUsers, users in
            if previousUsers.count > users.count {
                self.state = .unauthenticated
            }
        }
    }

    private func checkForBootstrap(user: User?) async {
        do {
            self.state = if let userSession = try await self.bootStrap(user: users.first) {
                .mainTab(userSession)
            } else {
                .unauthenticated
            }
        } catch {
            self.state = .failedToLoad
        }
    }
}
//
//#Preview {
//    RootView(bootStrap: Boot)
//        .modelContainer(for: User.self, inMemory: true)
//}
