//
//  SplashScreenView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import SwiftData
import User
import Websockets

struct SplashScreenView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.websocketClient) var websocketClient

    var body: some View {
        Button("Sign in") {
            modelContext.insert(User.stub)
            Task {
                try? await websocketClient.authenticate(userID: User.stub.id)
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
