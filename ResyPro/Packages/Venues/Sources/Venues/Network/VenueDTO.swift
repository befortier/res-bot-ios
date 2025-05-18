//
//  VenueDTO.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// Representation of a venue returned from the backend API.
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

/// Details about when reservations are released.
public struct BookingInfoDTO: Sendable, Equatable, Codable {
  public let daysOut: Int
  public let time: String
  public init(daysOut: Int, time: String) {
    self.daysOut = daysOut
    self.time = time
  }
}

/// Location data returned from the backend.
public struct LocationDTO: Equatable, Sendable, Codable {
  let timeZone: String
  let neighborhood: String
  let geo: GeoDTO
  let code: String
  let name: String
  let urlSlug: String
}

/// Coordinates returned from the backend.
public struct GeoDTO: Equatable, Sendable, Codable {
  let latitude: Double
  let longitude: Double

  private enum CodingKeys: String, CodingKey {
    case latitude = "lat"
    case longitude = "lon"
  }
}

/// Reservation slot returned from the backend.
public struct SlotDTO: Equatable, Sendable, Codable {
  let templateID: String
  let serviceID: String
  let seatingType: String
  let exactSeat: String
  let supportedPartySize: SupportedPartySizeDTO
}

/// Party size range returned from the backend.
public struct SupportedPartySizeDTO: Equatable, Sendable, Codable {
  let min: Int
  let max: Int
}
