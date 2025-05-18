import Foundation
import SwiftUI

/// Stores network call history persisted to disk.
public final class NetworkHistoryStore: ObservableObject {
    /// Shared singleton instance used by default.
    public static let shared = NetworkHistoryStore()

    /// The collection of recorded network calls.
    @Published public private(set) var records: [NetworkRecord] = []

    private let fileURL: URL
    private let queue = DispatchQueue(label: "NetworkHistoryStore")

    /// Creates a new store reading history from disk if available.
    /// - Parameter fileURL: Optional location for the persisted JSON file.
    public init(fileURL: URL? = nil) {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        self.fileURL = fileURL ?? directory.appendingPathComponent("network_history.json")
        load()
    }

    /// Adds a record and saves the history to disk.
    public func add(_ record: NetworkRecord) {
        queue.async { [weak self] in
            guard let self else { return }
            self.records.append(record)
            self.save()
        }
    }

    private func load() {
        queue.async { [weak self] in
            guard let self else { return }
            guard let data = try? Data(contentsOf: self.fileURL) else { return }
            if let decoded = try? JSONDecoder().decode([NetworkRecord].self, from: data) {
                DispatchQueue.main.async {
                    self.records = decoded
                }
            }
        }
    }

    private func save() {
        let data = try? JSONEncoder().encode(records)
        try? data?.write(to: fileURL)
    }
}

extension EnvironmentValues {
    /// The store tracking network calls.
    @Entry public var networkHistoryStore: NetworkHistoryStore = FatalErrorNetworkHistoryStore()
}

/// Fallback store that traps if used without being injected.
public final class FatalErrorNetworkHistoryStore: NetworkHistoryStore {
    public init() { super.init(fileURL: nil) }

    public override func add(_ record: NetworkRecord) {
        fatalError("NetworkHistoryStore not injected into environment")
    }
}
