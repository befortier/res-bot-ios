import Foundation

/// An interface describing the operations supported by a websocket client.
public protocol WebsocketClient: Sendable {
    /// Opens a websocket connection to the specified URL.
    /// - Parameter url: The server endpoint to connect to.
    func connect(url: URL) async

    /// Disconnects an open websocket connection.
    func disconnect() async

    /// Authenticates the connection using the provided user identifier.
    /// - Parameter userID: The identifier used for authentication.
    func authenticate(userID: String) async throws

    /// Observes events with the supplied name and decodes them to the given type.
    /// - Parameters:
    ///   - name: The name of the event to observe.
    ///   - type: The expected payload type.
    func observeEvent<T: Codable & Sendable>(named name: String, as type: T.Type) async -> AsyncStream<T>
}
