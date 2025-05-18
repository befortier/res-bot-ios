import Foundation
import DebugTools

/// ``WebsocketClient`` wrapper that records all events.
public actor RecordingWebsocketClient: WebsocketClient {
    private let wrapped: any WebsocketClient
    private let store: WebsocketHistoryStore

    /// Creates a new recording client.
    /// - Parameters:
    ///   - wrapped: The underlying ``WebsocketClient`` to call.
    ///   - store: Store used to persist websocket history.
    public init(
        wrapped: any WebsocketClient,
        store: WebsocketHistoryStore = .shared
    ) {
        self.wrapped = wrapped
        self.store = store
    }

    public func connect(url: URL) async {
        await wrapped.connect(url: url)
        store.add(
            WebsocketRecord(
                name: "connect",
                direction: .sent,
                payload: url.absoluteString
            )
        )
    }

    public func disconnect() async {
        await wrapped.disconnect()
        store.add(
            WebsocketRecord(
                name: "disconnect",
                direction: .sent,
                payload: nil
            )
        )
    }

    public func authenticate(userID: String) async throws {
        try await wrapped.authenticate(userID: userID)
        let payload = "{\"userId\":\"\(userID)\"}"
        store.add(
            WebsocketRecord(
                name: "authenticate",
                direction: .sent,
                payload: payload
            )
        )
    }

    public func observeEvent<T>(named name: String, as type: T.Type) async -> AsyncStream<T> where T : Codable & Sendable {
        let base = await wrapped.observeEvent(named: name, as: type)
        return AsyncStream { continuation in
            Task {
                for await value in base {
                    let payloadData = try? JSONEncoder().encode(value)
                    let payload = payloadData.flatMap { String(data: $0, encoding: .utf8) }
                    store.add(
                        WebsocketRecord(
                            name: name,
                            direction: .received,
                            payload: payload
                        )
                    )
                    continuation.yield(value)
                }
                continuation.finish()
            }
        }
    }
}
