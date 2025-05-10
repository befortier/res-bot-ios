//
//  VenueMapper.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/22/24.
//

import Foundation

protocol VenueMapper: Sendable {
    func map(dto: VenueDTO) -> Venue
}

struct VenueMapperLive: VenueMapper {
    func map(dto: VenueDTO) -> Venue {
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
