import Foundation
import SwiftData
import ProjectFoundation

/// Persists ``Notification`` objects in storage.
@MainActor
public protocol NotificationsStore: Sendable {
    /// Replaces all stored notifications with the provided list.
    func replace(_ notifications: [Notification]) throws
    /// Saves a single notification.
    func save(_ notification: Notification) throws
    /// Retrieves all notifications from storage.
    func fetchAll() throws -> [Notification]
    /// Timestamp of the last successful refresh.
    var lastUpdated: Date? { get }
}

/// ``NotificationsStore`` implementation backed by ``ModelContainer``.
public struct NotificationsStoreLive: NotificationsStore {
    private let container: any ModelContainerProtocol
    private let defaults: UserDefaults
    private let key = "notifications.lastUpdated"

    public init(
        container: any ModelContainerProtocol,
        defaults: UserDefaults = .standard
    ) {
        self.container = container
        self.defaults = defaults
    }

    public var lastUpdated: Date? {  defaults.object(forKey: key) as? Date }

    public func replace(_ notifications: [Notification]) throws {
        let context = container.mainContext
        let existing = try context.fetch(FetchDescriptor<Notification>())
        for note in existing { context.delete(note) }
        notifications.forEach(context.insert)
        try context.save()
        updateLastUpdatedIfNeeded()
    }

    public func save(_ notification: Notification) throws {
        let context = container.mainContext
        context.insert(notification)
        try context.save()
        updateLastUpdatedIfNeeded()
    }

    public func fetchAll() throws -> [Notification] {
        try container.mainContext.fetch(FetchDescriptor<Notification>())
    }

    private func updateLastUpdatedIfNeeded() {
        defaults.set(Date.now, forKey: key)
    }
}
