import Venues
import Foundation

/// Venue and its associated notification tickets.
public struct VenueNotification: Sendable, Equatable, Identifiable {
    public let venueID: Venue.ID
    public let notifications: [NotificationTicket]

    public var id: Int { venueID }

    public init(venueID: Int, notifications: [NotificationTicket]) {
        self.venueID = venueID
        self.notifications = notifications
    }
}
