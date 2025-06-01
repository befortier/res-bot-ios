import SwiftUI
import Venues
import DesignSystem
import SwiftData

/// Displays notifications in a calendar with a selectable date.
struct NotificationCalendarView: View {

    let venuesByID: [Int: Venue]

    @Binding var mode: CalendarGridView.Mode
    @Binding var selectedDate: Date
    @Environment(\.projectModelContainer) private var modelContainer: any ModelContainerProtocol

    private struct MergedTicket: Hashable {
        let venueID: Int
        var partySizes: [Int]
        var interval: DateInterval
    }

    private func notifications(for date: Date) -> [Notification] {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start) ?? start
        let predicate = #Predicate<Notification> {
            $0.startTime >= start && $0.startTime < end
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        return (try? modelContainer.mainContext.fetch(descriptor)) ?? []
    }

    private func hasNotification(on date: Date) -> Bool {
        !notifications(for: date).isEmpty
    }

    private var mergedTickets: [MergedTicket] {
        let tickets = notifications(for: selectedDate).map { $0.asTicket() }
        return VenueTicketMerger.merge(tickets).map {
            MergedTicket(venueID: $0.venueID, partySizes: $0.partySizes, interval: $0.interval)
        }
    }

    private func days(for date: Date, mode: CalendarGridView.Mode) -> [Date] {
        let calendar = Calendar.current
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
            guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: date)?.start else {
                return []
            }
            return (0..<7).compactMap { offset in
                calendar.date(byAdding: .day, value: offset, to: startOfWeek)
            }
        }
    }

    private var notificationDays: Set<Date> {
        let calendar = Calendar.current
        let range = days(for: selectedDate, mode: mode)
        return Set(range.compactMap { hasNotification(on: $0) ? calendar.startOfDay(for: $0) : nil })
    }

    private static let monthFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "LLLL yyyy"
        return f
    }()

    var body: some View {
        VStack(spacing: 8) {
            Text(Self.monthFormatter.string(from: selectedDate))
                .font(.design(.title3).bold())
                .frame(maxWidth: .infinity, alignment: .leading)

            IterableCalendarView(
                selectedDate: $selectedDate,
                mode: mode,
                notifications: notificationDays
            )

            ScrollView {
                if !mergedTickets.isEmpty {
                    LazyVStack(spacing: 8) {
                        ForEach(mergedTickets, id: \ .venueID) { ticket in
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
