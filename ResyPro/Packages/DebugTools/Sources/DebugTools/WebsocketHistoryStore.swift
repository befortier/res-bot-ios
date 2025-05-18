import Foundation

/// Persists websocket event history to disk.
public final class WebsocketHistoryStore: HistoryStore<WebsocketRecord> {
    /// Shared singleton instance used by default.
    public static let shared = WebsocketHistoryStore()

    /// Creates a new store reading history from disk if available.
    /// - Parameter fileURL: Optional location for the persisted JSON file.
    public init(fileURL: URL? = nil) {
        super.init(filename: "websocket_history.json", fileURL: fileURL)
    }
}
