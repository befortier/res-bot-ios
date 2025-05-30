import Network

/// ``Endpoint`` for retrieving all notifications.
struct GetNotificationsEndpoint: GetEndpoint {
  let baseURL: BaseURL = .backend
  let path: String = "/notifications"
  let queryParameters: [String: String]? = nil
  let headers: [String: String]? = ["Content-Type": "application/json"]
}
