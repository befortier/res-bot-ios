import Foundation
import Network
import Venues

/// Repository responsible for submitting and retrieving notifications.
public protocol NotificationRepository: Sendable {
    /// Sends the request to the backend.
    func submit(_ request: BulkNotificationSubmissionRequest) async throws

    /// Returns the notifications associated with the current user.
    func getAllNotifications() async throws -> [VenueNotification]
}

/// Default implementation using ``NetworkService``.
public struct NotificationRepositoryLive: NotificationRepository {
    private let networkService: any NetworkService
    private let encoder: JSONEncoder
    private let venueMapper: any VenueMapper
    private let venueStore: any VenueStore

    public init(
        networkService: any NetworkService,
        venueStore: any VenueStore,
        encoder: JSONEncoder = JSONEncoder(),
        venueMapper: any VenueMapper = VenueMapperLive()
    ) {
        self.networkService = networkService
        self.venueStore = venueStore
        self.encoder = encoder
        self.venueMapper = venueMapper
    }

    public func submit(_ request: BulkNotificationSubmissionRequest) async throws {
        try await networkService.fetch(
            from: BulkNotificationEndpoint(
                requestBody: request
            )
        )
    }

    public func getAllNotifications() async throws -> [VenueNotification] {
        let dtos: [VenueNotificationDTO] = try await networkService.fetch(from: GetNotificationsEndpoint())
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
}
