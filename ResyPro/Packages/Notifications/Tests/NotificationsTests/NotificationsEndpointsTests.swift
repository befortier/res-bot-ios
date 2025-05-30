import Testing
@testable import Notifications

struct NotificationsEndpointsTests {
    @Test func testByVenueEndpoint() {
        let endpoint = GetNotificationsByVenueEndpoint()
        #expect(endpoint.path == "/notifications-by-venue")
    }

    @Test func testByDateEndpoint() {
        let endpoint = GetNotificationsByDateEndpoint()
        #expect(endpoint.path == "/notifications-by-date")
    }
}
