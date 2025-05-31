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
                    LazyVStack(spacing: 8) {
                        ForEach(tickets, id: \ .self) { ticket in
                            NotificationCard(
                                viewState: .init(
                                    request: ticket,
                                    venue: venuesByID[ticket.venueID]
                                )
                            )
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
    }
}
