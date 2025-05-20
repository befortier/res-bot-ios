import Foundation

/// Request body for deleting a single notification.
struct DeleteNotificationRequest: Codable, Hashable, Sendable {
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

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        try container.encode(venueID, forKey: .venueID)
        try container.encode(formatter.string(from: startTime), forKey: .startTime)
        try container.encode(partySize, forKey: .partySize)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        venueID = try container.decode(Int.self, forKey: .venueID)
        partySize = try container.decode(Int.self, forKey: .partySize)
        let string = try container.decode(String.self, forKey: .startTime)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        guard let date = formatter.date(from: string) else {
            throw DecodingError.dataCorruptedError(
                forKey: .startTime,
                in: container,
                debugDescription: "Invalid ISO8601 date"
            )
        }
        startTime = date
    }
}
