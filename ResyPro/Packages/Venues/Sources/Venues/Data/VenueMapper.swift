//
//  VenueMapper.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//


import Foundation

/// A protocol defined in the Venues module.
public protocol VenueMapper: Sendable {
    func map(dto: VenueDTO) -> Venue
}

public struct VenueMapperLive: VenueMapper {
    public init() { }
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
