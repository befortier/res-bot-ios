import Testing
@testable import Notifications

struct NotificationCalendarMergeTests {
    @Test func testMergesSameVenueOnSameDay() {
        let calendar = Calendar.current
        let day = calendar.startOfDay(for: Date())
        let t1 = NotificationTicket(
            venueID: 1,
            interval: DateInterval(start: day.addingTimeInterval(0), end: day.addingTimeInterval(3600)),
            partySize: 3
        )
        let t2 = NotificationTicket(
            venueID: 1,
            interval: DateInterval(start: day.addingTimeInterval(7200), end: day.addingTimeInterval(10800)),
            partySize: 4
        )
        let notifications = [DateNotification(date: day, notifications: [t1, t2])]
        let result = NotificationCalendarView.merge(notifications)
        let merged = result[day]?.first
        #expect(merged?.interval.start == t1.interval.start)
        #expect(merged?.interval.end == t2.interval.end)
        #expect(merged?.partySizes == [3, 4])
    }

    @Test func testKeepsSeparateVenues() {
        let calendar = Calendar.current
        let day = calendar.startOfDay(for: Date())
        let t1 = NotificationTicket(
            venueID: 1,
            interval: DateInterval(start: day, end: day.addingTimeInterval(3600)),
            partySize: 2
        )
        let t2 = NotificationTicket(
            venueID: 2,
            interval: DateInterval(start: day.addingTimeInterval(1800), end: day.addingTimeInterval(5400)),
            partySize: 5
        )
        let notifications = [DateNotification(date: day, notifications: [t1, t2])]
        let result = NotificationCalendarView.merge(notifications)
        #expect(result[day]?.count == 2)
    }
}
