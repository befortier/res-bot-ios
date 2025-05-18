import Foundation
import SwiftUI

/// Stores network call history persisted to disk.
public final class NetworkHistoryStore: ObservableObject, @unchecked Sendable {
    /// Shared singleton instance used by default.
    public static let shared = NetworkHistoryStore()

    /// The collection of recorded network calls.
    @Published public private(set) var records: [NetworkRecord] = []

    private let fileURL: URL
    private let queue = DispatchQueue(label: "NetworkHistoryStore")
    private let maxRecords = 30

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
            self.records.sort { $0.date > $1.date }
            if self.records.count > self.maxRecords {
                self.records = Array(self.records.prefix(self.maxRecords))
            }
            self.save()
        }
    }

    /// Updates an existing record if present.
    public func update(_ record: NetworkRecord) {
        queue.async { [weak self] in
            guard let self else { return }
            guard let index = self.records.firstIndex(where: { $0.id == record.id }) else { return }
            self.records[index] = record
            self.records.sort { $0.date > $1.date }
            self.save()
        }
    }

    /// Deletes all stored network records from memory and disk.
    public func clear() {
        queue.async { [weak self] in
            guard let self else { return }
            self.records.removeAll()
            self.save()
        }
    }

    private func load() {
        queue.async { [weak self] in
            guard let self else { return }
            guard let data = try? Data(contentsOf: self.fileURL) else { return }
            if let decoded = try? JSONDecoder().decode([NetworkRecord].self, from: data) {
                let sorted = decoded.sorted { $0.date > $1.date }
                let trimmed = Array(sorted.prefix(self.maxRecords))
                DispatchQueue.main.async {
                    self.records = trimmed
                }
            }
        }
    }

    private func save() {
        records.sort { $0.date > $1.date }
        if records.count > maxRecords {
            records = Array(records.prefix(maxRecords))
        }
        let data = try? JSONEncoder().encode(records)
        try? data?.write(to: fileURL)
    }
}
