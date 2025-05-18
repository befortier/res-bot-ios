import Foundation
import Network

/// Repository responsible for submitting bulk notification requests.
public protocol BulkNotificationRepository: Sendable {
/// Sends the request to the backend.
func submit(_ request: BulkNotificationSubmissionRequest) async throws -> NotificationSubmissionResponse
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

public func submit(_ request: BulkNotificationSubmissionRequest) async throws -> NotificationSubmissionResponse {
let dayFormatter = DateFormatter()
dayFormatter.dateFormat = "yyyy-MM-dd"
let timeFormatter = DateFormatter()
timeFormatter.dateFormat = "HH:mm:ss"

let day = dayFormatter.string(from: request.interval.start)
let startTime = timeFormatter.string(from: request.interval.start)
let endTime = timeFormatter.string(from: request.interval.end)

var entries: [BulkNotificationRequest.NotificationRequest] = []
for venue in request.venueIDs {
for size in request.partySizeRange {
entries.append(
BulkNotificationRequest.NotificationRequest(
venueID: venue,
day: day,
timePreferredStart: startTime,
timePreferredEnd: endTime,
numSeats: size,
serviceTypeID: 2
)
)
}
}

let endpoint = BulkNotificationEndpoint(requestBody: BulkNotificationRequest(requests: entries))
return try await networkService.fetch(from: endpoint)
}
}
