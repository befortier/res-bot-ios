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

#if DEBUG
  import DebugTools
#endif

@MainActor
struct RootView: View {

  @StateObject private var viewModel = ViewModel()
  @Query private var users: [User]
  @Query private var resyConfigs: [ResyConfig]
  #if DEBUG
    @State private var showDebugMenu = false
  #endif

  var body: some View {
    Group {
      if let user = users.first,
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
    #if DEBUG
      .sheet(isPresented: $showDebugMenu) {
        DebugMenuView()
        .environment(\.networkHistoryStore, .shared)
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
    .modelContainer(for: ResyConfig.self, inMemory: true)
}
