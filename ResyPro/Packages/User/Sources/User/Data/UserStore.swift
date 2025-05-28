import Foundation
import SwiftData
import ProjectFoundation

/// Stores ``User`` objects in persistent storage.
@MainActor
public protocol UserStore: Sendable {
    /// Saves the provided user, replacing any existing entry with the same id.
    func save(_ user: User) throws
}

/// ``UserStore`` implementation using ``ModelContainer``.
public struct UserStoreLive: UserStore {
    private let container: any ModelContainerProtocol

    public init(container: any ModelContainerProtocol) {
        self.container = container
    }

    public func save(_ user: User) throws {
        let context = container.mainContext
        let predicate = #Predicate<User> { $0.id == user.id }
        let descriptor = FetchDescriptor(predicate: predicate)
        if let existing = try context.fetch(descriptor).first {
            context.delete(existing)
        }
        context.insert(user)
        try context.save()
    }
}
