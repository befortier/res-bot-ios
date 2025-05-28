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

    @Environment(\.websocketClient) var websocketClient
    @Environment(\.bootstrapUseCase) private var bootstrap
    @Query private var users: [User]

    var body: some View {
        Group {
            if let user = users.first {
                MainTabView(user: user)
            } else {
                OnboardingView(networkService: BasicNetworkServiceComposer.make())
            }
        }
        .maintainWebsocketConnection(user: users.first)
        .navigationViewStyle(.stack)
        .observeForDebug()
        .task { await bootstrap(user: users.first) }
        /*
         .onFirstAppear {
             do {
         guard let token else { onboarindgView() }
         guard let user = try await getUser(token)
         if error is 401 we will auto log out
         other errors should NOT clear it but just show a
               state = .loading
               guard let token = await currentToken
               try await refreshUser(token) // with retry
               user = newUser
             } catch {
                // Or maybe if we get a 401 on any request we log out.
                if 401 {
                  logout()
                }

             }
         }
         */
    }
}

#Preview {
    RootView()
        .modelContainer(for: User.self, inMemory: true)
}
