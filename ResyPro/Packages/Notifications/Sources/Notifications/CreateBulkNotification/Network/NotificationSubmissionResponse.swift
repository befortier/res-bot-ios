import Foundation

/// Response returned after submitting a bulk notification request.
public struct NotificationSubmissionResponse: Equatable, Sendable, Decodable {
	/// Results for each notification creation attempt.
	public let results: [ResultEntry]

	/// A single request result entry.
	public struct ResultEntry: Equatable, Sendable, Decodable {
		/// The originally submitted request.
		public let request: BulkNotificationRequest.NotificationRequest
		/// Indicates whether the notification was created.
		public let success: Bool
	}
}
