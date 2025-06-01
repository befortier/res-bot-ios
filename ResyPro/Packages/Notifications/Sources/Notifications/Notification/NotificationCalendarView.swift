import SwiftUI
import Venues
import DesignSystem

/// Displays notifications in a calendar with a selectable date.
struct NotificationCalendarView: View {

    let venuesByID: [Int: Venue]
    let merged: [Date: [MergedVenueTicket]]

    @Binding var mode: CalendarGridView.Mode
    @Binding var selectedDate: Date

    private var tickets: [MergedVenueTicket] {
        NotificationCalendarLogic.sort(
            tickets: merged[ Calendar.current.startOfDay(for: selectedDate)] ?? [],
            byNameUsing: venuesByID
        )
    }

    private var notificationDays: Set<Date> {
        NotificationCalendarLogic.notificationDays(
            selectedDate: selectedDate,
            mode: mode,
            merged: merged
        )
    }

    private static let monthFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "LLLL yyyy"
        return f
    }()

    var body: some View {
        VStack(spacing: 8) {
            Text(Self.monthFormatter.string(from: selectedDate))
                .font(.design(.title).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 8)

            IterableCalendarView(
                selectedDate: $selectedDate,
                mode: mode,
                notifications: notificationDays
            )

            ScrollView {
                if !tickets.isEmpty {
                    LazyVStack(spacing: 8) {
                        ForEach(tickets, id: \.venueID) { ticket in
                            let venue = venuesByID[ticket.venueID]
                            NotificationCard(
                                viewState: .init(
                                    venueName: venue?.name ?? "Venue \(ticket.venueID)",
                                    venueID: ticket.venueID,
                                    partySizes: ticket.partySizes,
                                    interval: ticket.interval,
                                    venueImageURL: venue?.images.first
                                )
                            )
                            .padding(.horizontal, 8)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }

        }
    }
}

extension NotificationCalendarView {
    static func offset(
        date: Date,
        mode: CalendarGridView.Mode,
        by value: Int
    ) -> Date {
        NotificationCalendarLogic.offset(date: date, mode: mode, by: value)
    }

    static func merge(_ entries: [DateNotification]) -> [Date: [MergedVenueTicket]] {
        NotificationCalendarLogic.merge(entries)
    }
}
