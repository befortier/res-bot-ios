//
//  VenueMapper.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// Converts a ``VenueDTO`` into a persistent ``Venue`` model.
public protocol VenueMapper: Sendable {
  /// Creates a ``Venue`` from the given DTO.
  func map(dto: VenueDTO) -> Venue
}

/// Default implementation of ``VenueMapper``.
public struct VenueMapperLive: VenueMapper {
  public init() {}
  public func map(dto: VenueDTO) -> Venue {
    return Venue(
      venueID: dto.venueID,
      name: dto.name,
      location: dto.location,
      images: dto.images,
      slots: dto.slots,
      needToKnow: dto.needToKnow,
      cuisineType: dto.cuisineType,
      priceRange: dto.priceRange,
      urlSlug: dto.urlSlug,
      bookingInfo: dto.bookingInfo
    )
  }

}
