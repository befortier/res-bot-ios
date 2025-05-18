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
#if DEBUG
import DebugTools
#endif

@MainActor
struct RootView: View {

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
        .navigationViewStyle(.stack)
#if DEBUG
        .sheet(isPresented: $showDebugMenu) {
            DebugMenuView()
                .environment(\.networkHistoryStore, .shared)
        }
        .overlay(
            ShakeDetector {
                showDebugMenu = true
            }
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
