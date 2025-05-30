import Foundation

/// Date and its associated notification tickets.
public struct DateNotification: Sendable, Equatable, Identifiable {
    public let date: Date
    public let notifications: [NotificationTicket]

    public var id: Date { date }

    public init(date: Date, notifications: [NotificationTicket]) {
        self.date = date
        self.notifications = notifications
    }
}
