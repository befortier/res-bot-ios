import Venues

/// Venue and its associated notification tickets.
struct VenueNotification: Sendable, Equatable, Identifiable {
	let venue: Venue
	let notifications: [NotificationTicket]

	var id: Int { venue.venueID }

	init(venue: Venue, notifications: [NotificationTicket]) {
		self.venue = venue
		self.notifications = notifications
	}
}
