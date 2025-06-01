import Foundation
import SwiftData
import Venues

/// Stored notification details.
@Model
public final class Notification: Equatable {
    @Attribute(.unique) public var id: UUID
    @Relationship public var venue: Venue
    public var startTime: Date
    public var endTime: Date
    public var partySize: Int

    public init(
        id: UUID = UUID(),
        startTime: Date,
        endTime: Date,
        partySize: Int,
        venue: Venue
    ) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.partySize = partySize
        self.venue = venue
    }

    public convenience init(
        ticket: NotificationTicket,
        venue: Venue
    ) {
        self.init(
            startTime: ticket.interval.start,
            endTime: ticket.interval.end,
            partySize: ticket.partySize,
            venue: venue
        )
    }

    public var interval: DateInterval {
        DateInterval(start: startTime, end: endTime)
    }

    public func asTicket() -> NotificationTicket {
        NotificationTicket(interval: interval, partySize: partySize, venueID: venue.id)
    }
}
