import SwiftUI
import Venues
import DesignSystem

/// Displays notifications in a calendar with a selectable date.
struct NotificationCalendarView: View {
    enum Mode: Int, CaseIterable {
        case week
        case month
    }

    let notifications: [DateNotification]
    let venuesByID: [Int: Venue]

    @Binding var mode: Mode
    @Binding var selectedDate: Date

    private var notificationsByDay: [Date: [NotificationTicket]] {
        let calendar = Calendar.current
        return Dictionary(grouping: notifications.flatMap { notif in
            notif.notifications.map { ($0, notif.date) }
        }) { pair in
            calendar.startOfDay(for: pair.1)
        }.mapValues { pairs in
            pairs.map { $0.0 }
        }
    }

    static func offset(date: Date, mode: Mode, by value: Int) -> Date {
        let calendar = Calendar.current
        let component: Calendar.Component = mode == .month ? .month : .weekOfYear
        return calendar.date(byAdding: component, value: value, to: date) ?? date
    }

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Button(action: { selectedDate = Self.offset(date: selectedDate, mode: mode, by: -1) }) {
                    Image(systemName: "chevron.left")
                }
                .buttonStyle(.borderless)

                Button(action: { selectedDate = Self.offset(date: selectedDate, mode: mode, by: 1) }) {
                    Image(systemName: "chevron.right")
                }
                .buttonStyle(.borderless)
            }

            CalendarGrid(
                mode: mode,
                notifications: notificationsByDay,
                selectedDate: $selectedDate
            )
                .frame(height: mode == .month ? 300 : 80)

            ScrollView {
                if let tickets = notificationsByDay[Calendar.current.startOfDay(for: selectedDate)] {
                    let grouped = Dictionary(grouping: tickets, by: \ .venueID)
                    let venues = grouped.compactMap { venuesByID[$0.key] }
                    VerticalVenueCardGridView(venues: venues) { state in
                        if let venueTickets = grouped[state.id] {
                            VStack(spacing: 4) {
                                VerticalVenueCard(viewState: state)
                                    .frame(height: 200)
                                SummaryLabel(tickets: venueTickets)
                            }
                        }
                    }
                }
            }
        }
    }
}

/// Displays a summary of party sizes and time for a set of tickets.
private struct SummaryLabel: View {
    let tickets: [NotificationTicket]

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter
    }()

    var body: some View {
        let sizes = Set(tickets.map(\.partySize)).sorted()
        let sizeText = sizes.map { "\($0)p" }.joined(separator: ",")
        let time = tickets.sorted { $0.interval.start < $1.interval.start }.first?.interval.start
        let timeText = time.map { SummaryLabel.timeFormatter.string(from: $0) } ?? ""
        Text("\(sizeText) • \(timeText)")
            .font(.design(.caption2))
            .foregroundStyle(Color.textSecondary)
    }
}

private struct CalendarGrid: View {
    let mode: NotificationCalendarView.Mode
    let notifications: [Date: [NotificationTicket]]
    @Binding var selectedDate: Date

    var body: some View {
        let calendar = Calendar.current
        let start: Date
        let days: [Date]
        if mode == .month {
            start = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate)) ?? selectedDate
            let range = calendar.range(of: .day, in: .month, for: start) ?? 1..<31
            days = range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: start) }
        } else {
            start = calendar.dateInterval(of: .weekOfYear, for: selectedDate)?.start ?? selectedDate
            days = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
        }

        let columns = Array(repeating: GridItem(.flexible()), count: 7)
        return LazyVGrid(columns: columns, spacing: 4) {
            ForEach(days, id: \ .self) { day in
                let dayNumber = calendar.component(.day, from: day)
                let hasRes = notifications[calendar.startOfDay(for: day)] != nil
                Text("\(dayNumber)")
                    .frame(maxWidth: .infinity)
                    .padding(4)
                    .background(calendar.isDate(day, inSameDayAs: selectedDate) ? Color.accentColor.opacity(0.2) : Color.clear)
                    .overlay(alignment: .bottomTrailing) {
                        if hasRes {
                            Circle().fill(Color.accentColor).frame(width: 6, height: 6)
                        }
                    }
                    .onTapGesture { selectedDate = day }
            }
        }
    }
}
