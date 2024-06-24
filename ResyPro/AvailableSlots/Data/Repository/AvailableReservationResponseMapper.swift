//
//  AvailableReservationResponseMapper.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

protocol AvailableReservationResponseMapper: Sendable {
    func map(dto: AvailableSlotsResponseDTO) -> [AvailableReservation]
}

struct AvailableReservationResponseMapperLive: AvailableReservationResponseMapper {
    func map(dto: AvailableSlotsResponseDTO) -> [AvailableReservation] {
        let venues = dto.results.venues
        return venues.flatMap { venueDTO in
            venueDTO.slots.map { slotDTO in
                AvailableReservation(
                    slotID: slotDTO.config.token,
                    time: slotDTO.date.start,
                    bookingAvailabilityStatus: slotDTO.availability.id
                )
            }
        }
    }
}
