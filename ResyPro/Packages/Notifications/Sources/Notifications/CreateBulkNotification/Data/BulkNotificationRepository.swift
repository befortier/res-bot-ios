import Foundation
import Network

/// Repository responsible for submitting bulk notification requests.
public protocol BulkNotificationRepository: Sendable {
    /// Sends the request to the backend.
    func submit(_ request: BulkNotificationSubmissionRequest) async throws
}

/// Default implementation using ``NetworkService``.
public struct BulkNotificationRepositoryLive: BulkNotificationRepository {
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
}
