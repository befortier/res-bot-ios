import SwiftUI
import Venues
import DesignSystem

/// Displays notifications in a calendar with a selectable date.
struct NotificationCalendarView: View {

    let notifications: [DateNotification]
    let venuesByID: [Int: Venue]

    @Binding var mode: CalendarGridView.Mode
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

    var body: some View {
        VStack(spacing: 8) {
            IterableCalendarView(
                selectedDate: $selectedDate,
                mode: mode,
                notifications: Set(notificationsByDay.keys)
            )

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
struct SummaryLabel: View {
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
