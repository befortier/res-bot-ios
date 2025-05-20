import Foundation

/// Request body for deleting a single notification.
public struct DeleteNotificationRequest: Encodable, Hashable, Sendable {
    let venueID: Int
    let startTime: Date
    let partySize: Int

    init(venueID: Int, startTime: Date, partySize: Int) {
        self.venueID = venueID
        self.startTime = startTime
        self.partySize = partySize
    }

    enum CodingKeys: String, CodingKey {
        case venueID
        case startTime
        case partySize
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        try container.encode(venueID, forKey: .venueID)
        try container.encode(formatter.string(from: startTime), forKey: .startTime)
        try container.encode(partySize, forKey: .partySize)
    }
}
