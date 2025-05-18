//
//  WebSocketLifecycleHandler.swift
//  Websockets
//
//  Created by Ben Fortier on 5/18/25.
//


import SwiftUI

struct WebSocketLifecycleHandler: ViewModifier {
    @Environment(\.scenePhase) private var scenePhase
    let websocketClient: WebSocketClient
    let websocketURL: URL
    let user: User?

    func body(content: Content) -> some View {
        content
            .task {
                await websocketClient.connect(url: websocketURL)
                if let user {
                    await websocketClient.authenticate(userId: user.id)
                }
            }
            .onChange(of: scenePhase) { _, newPhase in
                switch newPhase {
                case .active:
                    Task {
                        await websocketClient.connect(url: websocketURL)
                        if let user {
                            await websocketClient.authenticate(userId: user.id)
                        }
                    }
                case .inactive, .background:
                    Task {
                        await websocketClient.disconnect()
                    }
                @unknown default:
                    break
                }
            }
    }
}
