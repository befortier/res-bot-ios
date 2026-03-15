import NetworkKit
import Foundation

/// ``Endpoint`` for deleting an individual notification.
struct DeleteNotificationEndpoint: DeleteEndpoint {
    let baseURL: BaseURL = .backend
    let path: String = "/notifications"
    let queryParameters: [String: String]?
    let headers: [String: String]? = ["Content-Type": "application/json"]

    init(request: DeleteNotificationRequest) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        self.queryParameters = [
            "venueID": String(request.venueID),
            "startTime": formatter.string(from: request.startTime),
            "partySize": String(request.partySize)
        ]
    }
}
