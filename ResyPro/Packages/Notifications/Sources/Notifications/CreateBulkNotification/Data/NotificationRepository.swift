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
  private let mapper: any VenueNotificationResponseMapper

  public init(
    networkService: any NetworkService,
    encoder: JSONEncoder = JSONEncoder()
  ) {
    self.networkService = networkService
    self.encoder = encoder
    self.mapper = VenueNotificationResponseMapperLive()
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
    return mapper.map(dtos: dtos)
  }
}
