//
//  VenueDTO.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/22/24.
//

import Foundation

// Define VenueDTO struct
struct VenueDTO: Equatable, Sendable, Codable {
    let venueID: Int
    let name: String
    let location: LocationDTO
    let images: [URL]
    let slots: [SlotDTO]
    let needToKnow: String?
    let cuisineType: String
    let priceRange: Int
    let urlSlug: String
    let bookingInfo: BookingInfoDTO?
}

struct BookingInfoDTO: Sendable, Equatable, Codable {
    let daysOut: Int
    let time: String
}

// Define LocationDTO struct
struct LocationDTO: Equatable, Sendable, Codable {
    let timeZone: String
    let neighborhood: String
    let geo: GeoDTO
    let code: String
    let name: String
    let urlSlug: String
}

// Define GeoDTO struct
struct GeoDTO: Equatable, Sendable, Codable {
    let latitude: Double
    let longitude: Double

    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}

// Define SlotDTO struct
struct SlotDTO: Equatable, Sendable, Codable {
    let templateID: String
    let serviceID: String
    let seatingType: String
    let exactSeat: String
    let supportedPartySize: SupportedPartySizeDTO
}

// Define SupportedPartySizeDTO struct
struct SupportedPartySizeDTO: Equatable, Sendable, Codable {
    let min: Int
    let max: Int
}
