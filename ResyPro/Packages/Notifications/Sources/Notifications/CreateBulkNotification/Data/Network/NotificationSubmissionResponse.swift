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
        public let request: NotificationTicket
        /// Indicates whether the notification was created.
        public let success: Bool
    }
}
