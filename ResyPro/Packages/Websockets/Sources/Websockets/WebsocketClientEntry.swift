import SwiftUI

/// Provides the ``WebsocketClient`` instance available in the environment.
extension EnvironmentValues {
    /// The websocket client supplied through the environment.
    @Entry public var websocketClient: any WebsocketClient = FatalErrorWebsocketClient()
}

/// A fallback client that traps when used without being injected.
public actor FatalErrorWebsocketClient: WebsocketClient {
    public init() {}

    public func connect(url: URL) async {
        fatalError("WebsocketClient not injected into environment")
    }

    public func disconnect() async {
        fatalError("WebsocketClient not injected into environment")
    }

    public func authenticate(userID: String) async throws {
        fatalError("WebsocketClient not injected into environment")
    }

    public func observeEvent<T>(named name: String, as type: T.Type) -> AsyncStream<T> where T : Decodable & Sendable {
        fatalError("WebsocketClient not injected into environment")
    }
}
