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

@MainActor
struct RootView: View {

    @StateObject private var viewModel = ViewModel()
    @Environment(\.modelContext) var modelContext
    @Query private var users: [User]
    @Query private var resyConfigs: [ResyConfig]

    var body: some View {
        Group {
            if
                let user = users.first,
                let resyConfig = resyConfigs.first
            {
                MainTabView(
                    appState: AppState(
                        user: user,
                        resyConfig: resyConfig
                    )
                )
            } else {
                SplashScreenView()
            }
        }
        .navigationViewStyle(.stack)
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
        .modelContainer(for: ResyConfig.self, inMemory: true)
}
