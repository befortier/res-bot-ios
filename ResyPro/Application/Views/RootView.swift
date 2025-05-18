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
import Websockets

@MainActor
struct RootView: View {

  @Environment(\.websocketClient) var websocketClient
  @StateObject private var viewModel = ViewModel()
  @Query private var users: [User]

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
    .observeForDebug()
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
