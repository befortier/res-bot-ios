//
//  BulkNotificationSubmissionRequest.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import Foundation

/// A request to create reservation notifications across multiple venues.
public struct BulkNotificationSubmissionRequest: Equatable, Sendable, Encodable {
    /// The requested reservation date and time range.
    public let interval: DateInterval

    /// The requested party size range, e.g., 2...4.
    public let partySizeRange: ClosedRange<Int>

    /// The list of venue IDs to apply the request to.
    public let venueIDs: [Int]

    public init(
        interval: DateInterval,
        partySizeRange: ClosedRange<Int>,
        venueIDs: [Int]
    ) {
        self.interval = interval
        self.partySizeRange = partySizeRange
        self.venueIDs = venueIDs
    }
}
