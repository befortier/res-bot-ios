import Testing
@testable import Notifications
import Venues

struct NotificationModelTests {
    @Test func testInitStoresVenue() {
        let venue = Venue.laserWolf
        let ticket = NotificationTicket(
            interval: DateInterval(start: .now, duration: 60),
            partySize: 2,
            venueID: venue.venueID
        )
        let note = Notification(ticket: ticket, venue: venue)
        #expect(note.venueID == venue.venueID)
        #expect(note.venue?.venueID == venue.venueID)
    }
}
