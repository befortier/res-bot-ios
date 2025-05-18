//
//  EncodableDateInterval.swift
//  ProjectFoundation
//
//  Created by Ben Fortier on 5/18/25.
//

public import Foundation

@propertyWrapper
public struct CodableDateInterval: Codable, Hashable, Sendable {
    public var wrappedValue: DateInterval

    public init(wrappedValue: DateInterval) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let startString = try container.decode(String.self, forKey: .start)
        let endString = try container.decode(String.self, forKey: .end)

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let start = formatter.date(from: startString),
              let end = formatter.date(from: endString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .start,
                in: container,
                debugDescription: "Failed to decode ISO8601 date string"
            )
        }

        self.wrappedValue = DateInterval(start: start, end: end)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        try container.encode(formatter.string(from: wrappedValue.start), forKey: .start)
        try container.encode(formatter.string(from: wrappedValue.end), forKey: .end)
    }

    enum CodingKeys: String, CodingKey {
        case start
        case end
    }
}
