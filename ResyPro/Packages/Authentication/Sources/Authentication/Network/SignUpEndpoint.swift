import Network

/// Endpoint for registering a new user.
struct SignUpEndpoint: PostEndpoint {
    let baseURL: BaseURL = .backend
    let requestBody: RequestBody?
    let path: String = "/users/signup"
    let queryParameters: [String: String]? = nil
    let headers: [String: String]? = ["Content-Type": "application/json"]

    init(firstName: String, lastName: String, phoneNumber: String) {
        self.requestBody = RequestBody(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber
        )
    }
}

extension SignUpEndpoint {
    struct RequestBody: NetworkRequestBody {
        let firstName: String
        let lastName: String
        let phoneNumber: String
    }
}
