import Foundation
import DesignSystem

enum NotificationCalendarLogic {
    static func offset(date: Date, mode: CalendarGridView.Mode, by value: Int) -> Date {
        let calendar = Calendar.current
        let component: Calendar.Component = mode == .month ? .month : .weekOfYear
        return calendar.date(byAdding: component, value: value, to: date) ?? date
    }

    static func days(for date: Date, mode: CalendarGridView.Mode, calendar: Calendar = .current) -> [Date] {
        switch mode {
        case .month:
            guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)),
                  let range = calendar.range(of: .day, in: .month, for: startOfMonth) else {
                return []
            }
            return range.compactMap { day -> Date? in
                calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
            }
        case .week:
            guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: date)?.start else { return [] }
            return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
        }
    }

    static func merge(_ entries: [DateNotification]) -> [Date: [MergedVenueTicket]] {
        var result: [Date: [MergedVenueTicket]] = [:]
        for entry in entries {
            result[entry.date] = VenueTicketMerger.merge(entry.notifications)
        }
        return result
    }

    static func mergedByDate(from notifications: [Notification]) -> [Date: [MergedVenueTicket]] {
        let calendar = Calendar.current
        var groups: [Date: [NotificationTicket]] = [:]
        for note in notifications {
            let day = calendar.startOfDay(for: note.startTime)
            groups[day, default: []].append(note.asTicket())
        }
        var result: [Date: [MergedVenueTicket]] = [:]
        for (date, tickets) in groups {
            result[date] = VenueTicketMerger.merge(tickets)
        }
        return result
    }

    static func notificationDays(selectedDate: Date, mode: CalendarGridView.Mode, merged: [Date: [MergedVenueTicket]], calendar: Calendar = .current) -> Set<Date> {
        let range = days(for: selectedDate, mode: mode, calendar: calendar)
        return Set(range.compactMap { day in
            merged[calendar.startOfDay(for: day)] != nil ? calendar.startOfDay(for: day) : nil
        })
    }
}
