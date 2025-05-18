/// Request body for the backend bulk notification API.
public struct BulkNotificationRequest: Encodable, Sendable, Equatable {
	/// The individual notification requests to create.
	public let requests: [NotificationRequest]

	/// Creates a new request with the provided entries.
	/// - Parameter requests: The requests to submit.
	public init(requests: [NotificationRequest]) {
		self.requests = requests
	}

	/// Single venue and party size notification request.
	public struct NotificationRequest: Codable, Sendable, Equatable {
		/// The venue to monitor.
		public let venueID: Int
		/// The date to search.
		public let day: String
		/// Preferred start time in  format.
		public let timePreferredStart: String
		/// Preferred end time in  format.
		public let timePreferredEnd: String
		/// Desired party size.
		public let numSeats: Int
		/// Service type identifier.
		public let serviceTypeID: Int

		public init(
			venueID: Int,
			day: String,
			timePreferredStart: String,
			timePreferredEnd: String,
			numSeats: Int,
			serviceTypeID: Int
		) {
			self.venueID = venueID
			self.day = day
			self.timePreferredStart = timePreferredStart
			self.timePreferredEnd = timePreferredEnd
			self.numSeats = numSeats
			self.serviceTypeID = serviceTypeID
		}

		private enum CodingKeys: String, CodingKey {
			case venueID = "venue_id"
			case day
			case timePreferredStart = "time_preferred_start"
			case timePreferredEnd = "time_preferred_end"
			case numSeats = "num_seats"
			case serviceTypeID = "service_type_id"
		}
	}
}
