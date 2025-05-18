//
//  SupportedPartySize.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData

@Model
/// Range of party sizes a venue slot supports.
public final class SupportedPartySize: Equatable {
  public var min: Int
  public var max: Int
  @Relationship public var venueSlot: VenueSlot?

  public init(min: Int, max: Int) {
    self.min = min
    self.max = max
  }
}
