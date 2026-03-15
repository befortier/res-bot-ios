import NetworkKit

/// ``Endpoint`` for submitting bulk notification requests.
struct BulkNotificationEndpoint: PostEndpoint {
	let baseURL: BaseURL = .backend
	let path: String = "/bulk-notification"
	let queryParameters: [String: String]? = nil
	let headers: [String: String]? = ["Content-Type": "application/json"]

	let requestBody: BulkNotificationSubmissionRequest?

	init(requestBody: BulkNotificationSubmissionRequest) {
		self.requestBody = requestBody
	}
}
