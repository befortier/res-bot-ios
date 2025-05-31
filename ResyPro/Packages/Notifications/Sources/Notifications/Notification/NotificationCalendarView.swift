import SwiftUI
import Venues
import DesignSystem

/// Displays notifications in a calendar with a selectable date.
struct NotificationCalendarView: View {

    let notifications: [DateNotification]
    let venuesByID: [Int: Venue]

    @Binding var mode: CalendarGridView.Mode
    @Binding var selectedDate: Date

    private struct MergedTicket: Hashable {
        let venueID: Int
        var partySizes: [Int]
        var interval: DateInterval
    }

    private static func merge(_ notifications: [DateNotification]) -> [Date: [MergedTicket]] {
        let calendar = Calendar.current
        var byDay: [Date: [Int: MergedTicket]] = [:]

        for dateNotification in notifications {
            let day = calendar.startOfDay(for: dateNotification.date)
            var byVenue = byDay[day] ?? [:]

            for ticket in dateNotification.notifications {
                if var existing = byVenue[ticket.venueID] {
                    let start = min(existing.interval.start, ticket.interval.start)
                    let end = max(existing.interval.end, ticket.interval.end)
                    existing.interval = DateInterval(start: start, end: end)
                    if !existing.partySizes.contains(ticket.partySize) {
                        existing.partySizes.append(ticket.partySize)
                        existing.partySizes.sort()
                    }
                    byVenue[ticket.venueID] = existing
                } else {
                    byVenue[ticket.venueID] = MergedTicket(
                        venueID: ticket.venueID,
                        partySizes: [ticket.partySize],
                        interval: ticket.interval
                    )
                }
            }

            byDay[day] = byVenue
        }

        return byDay.mapValues { dict in
            dict.values.sorted { $0.interval.start < $1.interval.start }
        }
    }

    private var notificationsByDay: [Date: [MergedTicket]] {
        Self.merge(notifications)
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
                        ForEach(tickets, id: \ .venueID) { ticket in
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
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
    }
}
