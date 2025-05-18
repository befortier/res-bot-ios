import Foundation
import SwiftUI

/// Protocol for models stored in ``HistoryStore``.
public protocol HistoricalRecord: Codable, Identifiable {
    /// Timestamp of when the record was created.
    var date: Date { get }
}

/// Generic persistence layer for debug history records.
open class HistoryStore<Record: HistoricalRecord>: ObservableObject, @unchecked Sendable {
    /// The collection of persisted records.
    @Published public private(set) var records: [Record] = []

    private let fileURL: URL
    private let queue = DispatchQueue(label: "HistoryStore\(Record.self)")
    private let maxRecords: Int

    /// Creates a new store reading history from disk if available.
    /// - Parameters:
    ///   - filename: The name of the JSON file used for persistence.
    ///   - maxRecords: Maximum number of records to keep in memory.
    public init(filename: String, maxRecords: Int = 30, fileURL: URL? = nil) {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        self.fileURL = fileURL ?? directory.appendingPathComponent(filename)
        self.maxRecords = maxRecords
        load()
    }

    /// Adds a record and saves the history to disk.
    open func add(_ record: Record) {
        queue.async { [weak self] in
            guard let self else { return }
            self.records.append(record)
            self.sortAndTrim()
            self.save()
        }
    }

    /// Updates an existing record if present and saves to disk.
    open func update(_ record: Record) {
        queue.async { [weak self] in
            guard let self else { return }
            guard let index = self.records.firstIndex(where: { $0.id == record.id }) else { return }
            self.records[index] = record
            self.sortAndTrim()
            self.save()
        }
    }

    /// Deletes all stored records.
    open func clear() {
        queue.async { [weak self] in
            guard let self else { return }
            self.records.removeAll()
            self.save()
        }
    }

    // MARK: - Private

    private func load() {
        queue.async { [weak self] in
            guard let self else { return }
            guard let data = try? Data(contentsOf: self.fileURL) else { return }
            if let decoded = try? JSONDecoder().decode([Record].self, from: data) {
                let sorted = decoded.sorted { $0.date > $1.date }
                let trimmed = Array(sorted.prefix(self.maxRecords))
                DispatchQueue.main.async {
                    self.records = trimmed
                }
            }
        }
    }

    private func save() {
        sortAndTrim()
        let data = try? JSONEncoder().encode(records)
        try? data?.write(to: fileURL)
    }

    private func sortAndTrim() {
        records.sort { $0.date > $1.date }
        if records.count > maxRecords {
            records = Array(records.prefix(maxRecords))
        }
    }
}
