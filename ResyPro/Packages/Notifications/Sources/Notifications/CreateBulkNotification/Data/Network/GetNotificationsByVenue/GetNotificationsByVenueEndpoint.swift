import Network

/// ``Endpoint`` for retrieving notifications grouped by venue.
struct GetNotificationsByVenueEndpoint: GetEndpoint {
  let baseURL: BaseURL = .backend
  let path: String = "/notifications-by-venue"
  let queryParameters: [String: String]? = nil
  let headers: [String: String]? = ["Content-Type": "application/json"]
}
