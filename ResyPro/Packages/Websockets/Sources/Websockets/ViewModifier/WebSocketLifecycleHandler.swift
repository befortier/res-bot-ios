//
//  WebSocketLifecycleHandler.swift
//  Websockets
//
//  Created by Ben Fortier on 5/18/25.
//

public import SwiftUI
import User

struct WebSocketLifecycleHandler: ViewModifier {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.websocketClient) private var websocketClient
    private let websocketURL = URL.websocketServer
    let user: User?

    func body(content: Content) -> some View {
        content
            .task {
                await websocketClient.connect(url: websocketURL)
                if let user {
                    try? await websocketClient.authenticate(userID: user.id)
                }
            }
            .onChange(of: scenePhase) { _, newPhase in
                switch newPhase {
                case .active:
                    Task {
                        await websocketClient.connect(url: websocketURL)
                        if let user {
                           try? await websocketClient.authenticate(userID: user.id)
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

extension View {
    public func maintainWebsocketConnection(user: User?) -> some View {
        modifier(WebSocketLifecycleHandler(user: user))
    }
}
