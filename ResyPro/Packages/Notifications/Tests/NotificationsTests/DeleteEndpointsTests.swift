import Testing
@testable import Notifications

struct DeleteEndpointsTests {
    @Test func testSingleDeleteEndpoint() {
        let request = DeleteNotificationRequest(
            venueID: 1,
            startTime: Date(timeIntervalSince1970: 0),
            partySize: 2
        )
        let endpoint = DeleteNotificationEndpoint(request: request)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        let expected = [
            "venueID": "1",
            "startTime": formatter.string(from: request.startTime),
            "partySize": "2"
        ]
        #expect(endpoint.path == "/notifications")
        #expect(endpoint.queryParameters == expected)
    }

    @Test func testBulkDeleteEndpoint() {
        let req = DeleteNotificationRequest(
            venueID: 1,
            startTime: Date(timeIntervalSince1970: 0),
            partySize: 2
        )
        let endpoint = BulkDeleteNotificationsEndpoint(requestBody: [req])
        #expect(endpoint.path == "/bulk-delete-notifications")
    }
}
