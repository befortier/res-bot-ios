import NetworkKit

/// Endpoint to exchange a refresh token for a new access token.
struct RefreshEndpoint: PostEndpoint {
    let baseURL: BaseURL = .backend
    let requestBody: RequestBody?
    let path: String = "/users/refresh"
    let queryParameters: [String: String]? = nil
    let headers: [String: String]? = ["Content-Type": "application/json"]

    init(refreshToken: String) {
        self.requestBody = RequestBody(refreshToken: refreshToken)
    }
}

extension RefreshEndpoint {
    struct RequestBody: NetworkRequestBody {
        let refreshToken: String
    }
}
