//
//  Venue.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

//
//  SchedueledReservation.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData

@Model
final class Venue: Identifiable, Equatable {
    @Attribute(.unique) var venueID: Int
    
    @Relationship(inverse: \Location.venue) var location: Location
    @Relationship(inverse: \VenueSlot.venue) var slots: [VenueSlot]
    @Relationship(inverse: \BookingInfo.venue) var bookingInfo: BookingInfo?

    var name: String
    var images: [URL]
    var needToKnow: String?
    var cuisineType: String
    var priceRange: Int
    var urlSlug: String

    init(
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
    static let laserWolf = Venue(
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
        images: [URL(string: "https://lh3.googleusercontent.com/p/AF1QipOywvs1Z6wv9PKwRfT6qBNGslbrzxi47WkmBj00=s1360-w1360-h1020")!],
        slots: [
            SlotDTO(templateID: "", serviceID: "", seatingType: "Indoor Seating", exactSeat: "Ch", supportedPartySize: .init(min: 2, max: 4))
        ],
        needToKnow: "Some need to know text",
        cuisineType: "Mediterranian",
        priceRange: 3,
        urlSlug: "laser-wolf-bk",
        bookingInfo: nil
    )
}

#endif

