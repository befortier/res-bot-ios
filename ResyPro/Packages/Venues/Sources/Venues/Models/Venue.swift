//
//  Venue.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData

@Model
/// Core model describing a restaurant venue.
public final class Venue: Identifiable, Equatable {
  public var id: Int { venueID }
  @Attribute(.unique) public var venueID: Int

  @Relationship(inverse: \Location.venue) public var location: Location
  @Relationship(inverse: \VenueSlot.venue) public var slots: [VenueSlot]
  @Relationship(inverse: \BookingInfo.venue) public var bookingInfo: BookingInfo?

  public var name: String
  public var images: [URL]
  public var needToKnow: String?
  public var cuisineType: String
  public var priceRange: Int
  public var urlSlug: String

  public init(
    venueID: Int,
    name: String,
    location: LocationDTO,
    images: [URL],
    slots: [SlotDTO],
    needToKnow: String? = nil,
    cuisineType: String,
    priceRange: Int,
    urlSlug: String,
    bookingInfo: BookingInfoDTO?
  ) {
    self.venueID = venueID
    self.name = name
    self.location = Location(locationDTO: location)
    self.images = images
    self.slots = slots.map { VenueSlot(venueSlotDTO: $0) }
    self.needToKnow = needToKnow
    self.cuisineType = cuisineType
    self.priceRange = priceRange
    self.urlSlug = urlSlug
    self.bookingInfo = BookingInfo(bookingInfoDTO: bookingInfo)
  }
}

#if DEBUG

  extension Venue {
    @MainActor public static let laserWolf = Venue(
      venueID: 1,
      name: "Laser Wolf BK",
      location: LocationDTO(
        timeZone: "EST",
        neighborhood: "Brooklyn",
        geo: GeoDTO(latitude: 0, longitude: 0),
        code: "bk",
        name: "brooklyn",
        urlSlug: "bk-slug"
      ),
      images: [
        URL(
          string:
            "https://lh3.googleusercontent.com/p/AF1QipOywvs1Z6wv9PKwRfT6qBNGslbrzxi47WkmBj00=s1360-w1360-h1020"
        )!
      ],
      slots: [
        SlotDTO(
          templateID: "", serviceID: "", seatingType: "Indoor Seating", exactSeat: "Ch",
          supportedPartySize: .init(min: 2, max: 4))
      ],
      needToKnow: "Some need to know text",
      cuisineType: "Mediterranian",
      priceRange: 3,
      urlSlug: "laser-wolf-bk",
      bookingInfo: nil
    )
  }

#endif
