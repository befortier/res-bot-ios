import Foundation
import Network

/// Repository responsible for submitting and retrieving notifications.
public protocol NotificationRepository: Sendable {
  /// Sends the request to the backend.
  func submit(_ request: BulkNotificationSubmissionRequest) async throws

  /// Returns the notifications associated with the current user.
  func getAllNotifications() async throws -> [NotificationSubmissionResponse.RequestResult]
}

/// Default implementation using ``NetworkService``.
public struct NotificationRepositoryLive: NotificationRepository {
  private let networkService: any NetworkService
  private let encoder: JSONEncoder

  public init(
    networkService: any NetworkService,
    encoder: JSONEncoder = JSONEncoder()
  ) {
    self.networkService = networkService
    self.encoder = encoder
  }

  public func submit(_ request: BulkNotificationSubmissionRequest) async throws {
    try await networkService.fetch(
      from: BulkNotificationEndpoint(
        requestBody: request
      )
    )
  }

  public func getAllNotifications() async throws -> [NotificationSubmissionResponse.RequestResult] {
    try await networkService.fetch(from: NotificationsEndpoint())
  }
}
