//
//  VenueDTO.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//


import Foundation

// Define VenueDTO struct
/// A struct defined in the Venues module.
public struct VenueDTO: Equatable, Sendable, Codable {
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

public struct BookingInfoDTO: Sendable, Equatable, Codable {
    public let daysOut: Int
    public let time: String
    public init(daysOut: Int, time: String) {
        self.daysOut = daysOut
        self.time = time
    }
}

// Define LocationDTO struct
public struct LocationDTO: Equatable, Sendable, Codable {
    let timeZone: String
    let neighborhood: String
    let geo: GeoDTO
    let code: String
    let name: String
    let urlSlug: String
}

// Define GeoDTO struct
public struct GeoDTO: Equatable, Sendable, Codable {
    let latitude: Double
    let longitude: Double

    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}

// Define SlotDTO struct
public struct SlotDTO: Equatable, Sendable, Codable {
    let templateID: String
    let serviceID: String
    let seatingType: String
    let exactSeat: String
    let supportedPartySize: SupportedPartySizeDTO
}

// Define SupportedPartySizeDTO struct
public struct SupportedPartySizeDTO: Equatable, Sendable, Codable {
    let min: Int
    let max: Int
}
