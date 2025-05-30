import Venues

/// Network response representation for a venue and its notifications.
struct VenueNotificationDTO: Equatable, Sendable, Decodable {
    let venue: VenueDTO
    let notifications: [NotificationTicket]

    enum CodingKeys: String, CodingKey {
        case venue
        case notifications = "reservations"
    }
}
