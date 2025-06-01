import Testing
@testable import Notifications

struct VenueTicketMergerTests {
    @Test func testMergesSameVenue() {
        let start = Date()
        let t1 = NotificationTicket(
            venueID: 1,
            interval: DateInterval(start: start, end: start.addingTimeInterval(60)),
            partySize: 3
        )
        let t2 = NotificationTicket(
            venueID: 1,
            interval: DateInterval(start: start.addingTimeInterval(120), end: start.addingTimeInterval(180)),
            partySize: 4
        )
        let merged = VenueTicketMerger.merge([t1, t2])
        #expect(merged.count == 1)
        #expect(merged[0].partySizes == [3,4])
        #expect(merged[0].interval.start == t1.interval.start)
        #expect(merged[0].interval.end == t2.interval.end)
    }

    @Test func testKeepsSeparateVenues() {
        let start = Date()
        let t1 = NotificationTicket(
            venueID: 1,
            interval: DateInterval(start: start, end: start.addingTimeInterval(60)),
            partySize: 3
        )
        let t2 = NotificationTicket(
            venueID: 2,
            interval: DateInterval(start: start, end: start.addingTimeInterval(60)),
            partySize: 5
        )
        let merged = VenueTicketMerger.merge([t1, t2])
        #expect(merged.count == 2)
    }
}
