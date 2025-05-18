import Network

/// Endpoint used to authenticate an existing user.
struct LoginEndpoint: PostEndpoint {
    let baseURL: BaseURL = .backend
    let requestBody: RequestBody?
    let path: String = "/users/login"
    let queryParameters: [String: String]? = nil
    let headers: [String: String]? = ["Content-Type": "application/json"]

    init(phoneNumber: String) {
        self.requestBody = RequestBody(phoneNumber: phoneNumber)
    }
}

extension LoginEndpoint {
    struct RequestBody: NetworkRequestBody {
        let phoneNumber: String
    }
}
