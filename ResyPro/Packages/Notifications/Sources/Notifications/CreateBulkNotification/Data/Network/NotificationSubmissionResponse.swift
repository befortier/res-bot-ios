import Foundation
import ProjectFoundation
import Venues

/// Response returned after submitting a bulk notification request.
public struct NotificationSubmissionResponse: Hashable, Sendable, Decodable {
    /// Results for each notification creation attempt.
    public let results: [ResultEntry]
    
    /// Represents the outcome of a single notification scheduling attempt.
    public struct ResultEntry: Hashable, Sendable, Codable {
        /// The originally submitted request.
        public let request: ReservationTicket
        /// Indicates whether the notification was created.
        public let success: Bool
    }
}

/// The request details originally sent to the server.
public struct ReservationTicket: Hashable, Sendable, Codable {
    @CodableDateInterval public var interval: DateInterval
    public let partySize: Int
    public let venueID: Venue.ID

    enum CodingKeys: String, CodingKey {
        case interval
        case partySize = "num_seats"
        case venueID = "venue_id"
    }
}
