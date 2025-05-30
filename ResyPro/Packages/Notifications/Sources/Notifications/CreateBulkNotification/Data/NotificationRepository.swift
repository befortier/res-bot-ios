import Foundation
import Network
import Venues

/// Repository responsible for submitting and retrieving notifications.
public protocol NotificationRepository: Sendable {
    /// Sends the request to the backend.
    func submit(_ request: BulkNotificationSubmissionRequest) async throws

    /// Returns the notifications grouped by venue.
    func getNotificationsByVenue() async throws -> [VenueNotification]

    /// Returns the notifications grouped by date.
    func getNotificationsByDate() async throws -> [DateNotification]

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

    public init(
        networkService: any NetworkService,
        venueStore: any VenueStore,
        venueMapper: any VenueMapper = VenueMapperLive()
    ) {
        self.networkService = networkService
        self.venueStore = venueStore
        self.venueMapper = venueMapper
    }

    public func submit(_ request: BulkNotificationSubmissionRequest) async throws {
        try await networkService.fetch(
            from: BulkNotificationEndpoint(
                requestBody: request
            )
        )
    }

    public func getNotificationsByVenue() async throws -> [VenueNotification] {
        let dtos: [VenueNotificationDTO] = try await networkService.fetch(from: GetNotificationsByVenueEndpoint())
        return await MainActor.run {
            dtos.map { dto in
                let venue = venueMapper.map(dto: dto.venue)
                try? venueStore.saveIfNeeded(venue)
                return VenueNotification(
                    venueID: venue.venueID,
                    notifications: dto.notifications
                )
            }
        }
    }

    public func getNotificationsByDate() async throws -> [DateNotification] {
        let dtos: [DateNotificationDTO] = try await networkService.fetch(
            from: GetNotificationsByDateEndpoint()
        )
        return dtos.map { dto in
            DateNotification(date: dto.date, notifications: dto.notifications)
        }
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
}

