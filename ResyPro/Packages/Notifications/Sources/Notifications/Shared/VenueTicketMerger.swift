import Foundation

struct MergedVenueTicket: Hashable {
    let venueID: Int
    var partySizes: [Int]
    var interval: DateInterval
}

enum VenueTicketMerger {
    static func merge(_ tickets: [NotificationTicket]) -> [MergedVenueTicket] {
        var byVenue: [Int: MergedVenueTicket] = [:]
        for ticket in tickets {
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
                byVenue[ticket.venueID] = MergedVenueTicket(
                    venueID: ticket.venueID,
                    partySizes: [ticket.partySize],
                    interval: ticket.interval
                )
            }
        }
        return byVenue.values.sorted { $0.interval.start < $1.interval.start }
    }
}
