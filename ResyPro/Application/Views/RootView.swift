//
//  RootView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import SwiftData
import User
import Websockets

#if DEBUG
import DebugTools
#endif

@MainActor
struct RootView: View {

    @Environment(\.websocketClient) var websocketClient
    @StateObject private var viewModel = ViewModel()
    @Query private var users: [User]
#if DEBUG
    @State private var showDebugMenu = false
#endif

    var body: some View {
        Group {
            if let user = users.first {
                MainTabView(user: user)
            } else {
                SplashScreenView()
            }
        }
        .maintainWebsocketConnection(user: users.first)
        .navigationViewStyle(.stack)
#if DEBUG
        .sheet(isPresented: $showDebugMenu) {
            DebugMenuView()
                .environmentObject(NetworkHistoryStore.shared)
        }
        
        .overlay(
            ShakeDetector {
                showDebugMenu = true
            }
            .allowsHitTesting(false)
        )
#endif
    }
}

extension RootView {
    @MainActor
    class ViewModel: ObservableObject {

        init() {}

        func restoreCurrentUser(userID: String) async throws -> User {
            return .stub
        }
    }
}


#Preview {
    RootView()
        .modelContainer(for: User.self, inMemory: true)
}
