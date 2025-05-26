import Foundation

/// Captures a single websocket event.
public struct WebsocketRecord: Codable, Identifiable, HistoricalRecord, Sendable {
    /// Indicates whether the event was sent or received.
    public enum Direction: String, Codable, Sendable {
        case sent
        case received
    }

    /// Unique identifier for the event.
    public let id: UUID
    /// Timestamp of when the event occurred.
    public let date: Date
    /// Name of the websocket event.
    public let name: String
    /// Direction of the event relative to the client.
    public let direction: Direction
    /// Optional JSON payload string.
    public let payload: String?

    public init(
        id: UUID = UUID(),
        date: Date = Date(),
        name: String,
        direction: Direction,
        payload: String? = nil
    ) {
        self.id = id
        self.date = date
        self.name = name
        self.direction = direction
        self.payload = payload
    }
}
