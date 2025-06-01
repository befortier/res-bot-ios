import Foundation
import Network
import Venues
import SwiftUI

/// Repository responsible for submitting and retrieving notifications.
public protocol NotificationRepository: Sendable {
    /// Sends the request to the backend.
    func submit(_ request: BulkNotificationSubmissionRequest) async throws

    /// Forces a refresh from the backend replacing any cached notifications.
    func refreshNotifications() async throws

    /// Saves a notification ticket to persistent storage.
    @MainActor func save(_ ticket: NotificationTicket) throws

    /// Deletes multiple notifications.
    func delete(_ requests: [DeleteNotificationRequest]) async throws

    /// Deletes a single notification.
    func delete(_ request: DeleteNotificationRequest) async throws
}

/// Default implementation using ``NetworkService``.
public struct NotificationRepositoryLive: NotificationRepository {
    private let networkService: any NetworkService
    private let venueMapper: any VenueMapper
    private let venueStore: any VenueStore
    private let notificationsStore: any NotificationsStore

    public init(
        networkService: any NetworkService,
        venueStore: any VenueStore,
        notificationsStore: any NotificationsStore,
        venueMapper: any VenueMapper = VenueMapperLive()
    ) {
        self.networkService = networkService
        self.venueStore = venueStore
        self.notificationsStore = notificationsStore
        self.venueMapper = venueMapper
    }

    public func submit(_ request: BulkNotificationSubmissionRequest) async throws {
        try await networkService.fetch(
            from: BulkNotificationEndpoint(
                requestBody: request
            )
        )
    }

    public func delete(_ requests: [DeleteNotificationRequest]) async throws {
        try await networkService.fetch(
            from: BulkDeleteNotificationsEndpoint(requestBody: requests)
        )
    }

    public func delete(_ request: DeleteNotificationRequest) async throws {
        try await networkService.fetch(
            from: DeleteNotificationEndpoint(request: request)
        )
    }

    public func refreshNotifications() async throws {
        let tickets: [NotificationTicket] = try await networkService.fetch(
            from: GetNotificationsEndpoint()
        )
        let notes = tickets.map(Notification.init(ticket:))
        try await MainActor.run {
            try notificationsStore.replace(notes)
        }
    }

    public func save(_ ticket: NotificationTicket) throws {
        try notificationsStore.save(Notification(ticket: ticket))
    }
}
