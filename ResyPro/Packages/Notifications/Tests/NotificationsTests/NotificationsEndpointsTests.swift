import Testing
@testable import Notifications

struct NotificationsEndpointsTests {
    @Test func testNotificationsEndpoint() {
        let endpoint = GetNotificationsEndpoint()
        #expect(endpoint.path == "/notifications")
    }
}
