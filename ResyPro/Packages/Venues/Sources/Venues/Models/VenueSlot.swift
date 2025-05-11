//
//  VenueSlot.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//


import Foundation
import SwiftData

@Model
public final class VenueSlot: Equatable {
    public var templateID: String
    public var serviceID: String
    public var seatingType: String
    public var exactSeat: String
    @Relationship(inverse: \SupportedPartySize.venueSlot) public var supportedPartySize: SupportedPartySize
    @Relationship public var venue: Venue?

    public init(
        templateID: String,
        serviceID: String,
        seatingType: String,
        exactSeat: String,
        supportedPartySize: SupportedPartySizeDTO
    ) {
        self.templateID = templateID
        self.serviceID = serviceID
        self.seatingType = seatingType
        self.exactSeat = exactSeat
        self.supportedPartySize = SupportedPartySize(
            min: supportedPartySize.min,
            max: supportedPartySize.max
        )
    }

    public convenience init(venueSlotDTO: SlotDTO) {
        self.init(
            templateID: venueSlotDTO.templateID,
            serviceID: venueSlotDTO.serviceID,
            seatingType: venueSlotDTO.seatingType,
            exactSeat: venueSlotDTO.exactSeat,
            supportedPartySize: venueSlotDTO.supportedPartySize
        )
    }
}
