import Venues

/// Venue and its associated notification tickets.
public struct VenueNotification: Sendable, Equatable, Identifiable {
    public let venue: Venue
    public let notifications: [NotificationTicket]

    public var id: Int { venue.venueID }

    public init(venue: Venue, notifications: [NotificationTicket]) {
		self.venue = venue
		self.notifications = notifications
	}
}
