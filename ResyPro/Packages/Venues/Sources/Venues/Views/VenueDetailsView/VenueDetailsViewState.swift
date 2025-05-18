//
//  VenueDetailsViewState.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import Foundation

/// Immutable data used to populate ``VenueDetailsView``.

public struct VenueDetailsViewState: Equatable {
  public let imageURL: URL?
  public let name: String
  public let cuisineType: String
  public let priceRange: Int
  public let neighborhood: String
  public let city: String
  public let needToKnow: String?

  public init(venue: Venue) {
    self.imageURL = venue.images.first
    self.name = venue.name
    self.cuisineType = venue.cuisineType
    self.priceRange = venue.priceRange
    self.neighborhood = venue.location.neighborhood
    self.city = venue.location.name
    self.needToKnow = venue.needToKnow
  }
}
