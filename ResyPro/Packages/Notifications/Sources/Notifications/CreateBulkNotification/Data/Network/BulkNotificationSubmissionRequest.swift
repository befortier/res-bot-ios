//
//  BulkNotificationSubmissionRequest.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import Foundation
import ProjectFoundation

/// A request to create reservation notifications across multiple venues.
public struct BulkNotificationSubmissionRequest: Hashable, Sendable, Codable {
  /// The requested reservation date and time range.
  @CodableDateInterval public var interval: DateInterval

  /// The requested party size range, e.g., 2...4.
  @CodableClosedRange public var partySizeRange: ClosedRange<Int>

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
