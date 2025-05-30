import Foundation

/// Network response representation for a date and its notifications.
struct DateNotificationDTO: Equatable, Sendable, Decodable {
    let date: Date
    let notifications: [NotificationTicket]

    enum CodingKeys: String, CodingKey {
        case date
        case notifications = "reservations"
    }
}
