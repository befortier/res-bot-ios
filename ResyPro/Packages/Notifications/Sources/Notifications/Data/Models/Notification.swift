import Foundation
import SwiftData

/// Stored notification details.
@Model
public final class Notification: Equatable {
    @Attribute(.unique) public var id: UUID
    public var venueID: Int
    public var startTime: Date
    public var endTime: Date
    public var partySize: Int

    public init(
        id: UUID = UUID(),
        venueID: Int,
        startTime: Date,
        endTime: Date,
        partySize: Int
    ) {
        self.id = id
        self.venueID = venueID
        self.startTime = startTime
        self.endTime = endTime
        self.partySize = partySize
    }

    public convenience init(ticket: NotificationTicket) {
        self.init(
            venueID: ticket.venueID,
            startTime: ticket.interval.start,
            endTime: ticket.interval.end,
            partySize: ticket.partySize
        )
    }

    public var interval: DateInterval {
        DateInterval(start: startTime, end: endTime)
    }

    public func asTicket() -> NotificationTicket {
        NotificationTicket(interval: interval, partySize: partySize, venueID: venueID)
    }
}
