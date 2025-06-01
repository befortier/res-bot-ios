import Testing
@testable import Notifications
import Venues

struct NotificationCalendarSortTests {
    private func makeVenue(id: Int, name: String) -> Venue {
        Venue(
            venueID: id,
            name: name,
            location: .init(
                timeZone: "",
                neighborhood: "",
                geo: .init(latitude: 0, longitude: 0),
                code: "",
                name: "",
                urlSlug: ""
            ),
            images: [],
            slots: [],
            needToKnow: nil,
            cuisineType: "",
            priceRange: 1,
            urlSlug: "",
            bookingInfo: nil
        )
    }

    @Test func testSortsByVenueName() {
        let tickets = [
            MergedVenueTicket(
                venueID: 1,
                partySizes: [2],
                interval: .init(start: .now, duration: 1)
            ),
            MergedVenueTicket(
                venueID: 2,
                partySizes: [2],
                interval: .init(start: .now, duration: 1)
            )
        ]
        let venues: [Int: Venue] = [
            1: makeVenue(id: 1, name: "Bravo"),
            2: makeVenue(id: 2, name: "Alpha")
        ]
        let sorted = NotificationCalendarLogic.sort(tickets: tickets, byNameUsing: venues)
        #expect(sorted.map(\.venueID) == [2, 1])
    }
}
