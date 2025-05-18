//
//  HorizontalVenueCardModel.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import Foundation

/// Data model for ``HorizontalVenueCard``.

public struct HorizontalVenueCardModel: Sendable, Equatable, Identifiable {
  public let id: Int
  public let imageURL: URL?
  public let name: String
  public let cuisineType: String
  public let priceRange: Int
  public let neighborhood: String
  public let locationName: String

  public init(
    id: Int,
    imageURL: URL?,
    name: String,
    cuisineType: String,
    priceRange: Int,
    neighborhood: String,
    locationName: String
  ) {
    self.id = id
    self.imageURL = imageURL
    self.name = name
    self.cuisineType = cuisineType
    self.priceRange = priceRange
    self.neighborhood = neighborhood
    self.locationName = locationName
  }

  public init(venue: Venue) {
    self.init(
      id: venue.venueID,
      imageURL: venue.images.first,
      name: venue.name,
      cuisineType: venue.cuisineType,
      priceRange: venue.priceRange,
      neighborhood: venue.location.neighborhood,
      locationName: venue.location.name
    )
  }
}
