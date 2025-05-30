import Testing
@testable import Notifications

struct CalendarNavigationTests {
    @Test func testMonthForward() {
        let date = Date(timeIntervalSince1970: 0)
        let newDate = NotificationCalendarView.offset(date: date, mode: .month, by: 1)
        let expected = Calendar.current.date(byAdding: .month, value: 1, to: date)!
        #expect(Calendar.current.isDate(newDate, equalTo: expected, toGranularity: .day))
    }

    @Test func testWeekBackward() {
        let date = Date(timeIntervalSince1970: 0)
        let newDate = NotificationCalendarView.offset(date: date, mode: .week, by: -1)
        let expected = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: date)!
        #expect(Calendar.current.isDate(newDate, equalTo: expected, toGranularity: .day))
    }
}
