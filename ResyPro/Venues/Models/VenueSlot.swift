//
//  VenueSlot.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/24/24.
//

import Foundation
import SwiftData

@Model
final class VenueSlot: Equatable {
    var templateID: String
    var serviceID: String
    var seatingType: String
    var exactSeat: String
    @Relationship(inverse: \SupportedPartySize.venueSlot) var supportedPartySize: SupportedPartySize
    @Relationship var venue: Venue?

    init(
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

    convenience init(venueSlotDTO: SlotDTO) {
        self.init(
            templateID: venueSlotDTO.templateID,
            serviceID: venueSlotDTO.serviceID,
            seatingType: venueSlotDTO.seatingType,
            exactSeat: venueSlotDTO.exactSeat,
            supportedPartySize: venueSlotDTO.supportedPartySize
        )
    }
}
