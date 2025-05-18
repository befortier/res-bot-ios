import Foundation
import Venues
import ProjectFoundation

/// Response returned after submitting a bulk notification request.
public struct NotificationSubmissionResponse: Hashable, Sendable, Decodable {
	/// Results for each notification creation attempt.
	public let results: [ResultEntry]

	/// A single request result entry.
	public struct ResultEntry: Hashable, Sendable, Decodable {
		/// The originally submitted request.
		public let request: RequestResult
		/// Indicates whether the notification was created.
		public let success: Bool
	}

    public struct RequestResult: Hashable, Sendable, Decodable {
        @CodableDateInterval public var interval: DateInterval
        public let partySize: Int
        public let venueID: Venue.ID

        enum CodingKeys: String, CodingKey {
            case venueID = "venue_id"
            case day
            case timePreferredStart = "time_preferred_start"
            case timePreferredEnd = "time_preferred_end"
            case partySize = "num_seats"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            let day = try container.decode(String.self, forKey: .day)
            let startTime = try container.decode(String.self, forKey: .timePreferredStart)
            let endTime = try container.decode(String.self, forKey: .timePreferredEnd)

            let venueID = try container.decode(Int.self, forKey: .venueID)
            let partySize = try container.decode(Int.self, forKey: .partySize)

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)

            guard let start = formatter.date(from: "\(day) \(startTime)"),
                  let end = formatter.date(from: "\(day) \(endTime)") else {
                throw DecodingError.dataCorruptedError(
                    forKey: .timePreferredStart,
                    in: container,
                    debugDescription: "Failed to parse start or end time into Date"
                )
            }

            self.interval = DateInterval(start: start, end: end)
            self.venueID = venueID
            self.partySize = partySize
        }
    }
}
