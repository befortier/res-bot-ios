import NetworkKit

/// ``Endpoint`` for deleting multiple notifications at once.
struct BulkDeleteNotificationsEndpoint: PostEndpoint {
    let baseURL: BaseURL = .backend
    let path: String = "/bulk-delete-notifications"
    let queryParameters: [String: String]? = nil
    let headers: [String: String]? = ["Content-Type": "application/json"]

    let requestBody: [DeleteNotificationRequest]?

    init(requestBody: [DeleteNotificationRequest]) {
        self.requestBody = requestBody
    }
}
