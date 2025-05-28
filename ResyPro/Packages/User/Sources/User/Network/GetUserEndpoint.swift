import Network

/// ``Endpoint`` for retrieving a user by identifier.
struct GetUserEndpoint: GetEndpoint {
    let baseURL: BaseURL = .backend
    /// Identifier of the user to fetch.
    let userID: String

    var path: String { "/user/\(userID)" }
    let queryParameters: [String: String]? = nil
    let headers: [String: String]? = nil
}
