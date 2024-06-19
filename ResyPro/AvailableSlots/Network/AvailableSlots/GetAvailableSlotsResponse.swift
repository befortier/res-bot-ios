//
//  GetAvailableSlotsResponse.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

struct AvailableSlotsResponseDTO: ResyDTOModel {
    let results: AvailableSlotsResultsDTO
}

struct AvailableSlotsResultsDTO: ResyDTOModel {
    let venues: [AvailableSlotsVenueDTO]
}

struct AvailableSlotsVenueDTO: ResyDTOModel {
    let slots: [ResySlotDTO]
}

struct ResySlotDTO: ResyDTOModel {
    let availability: BookingAvailabilityStatus
    let config: ResySlotConfigDTO
    let date: ResySlotDateDTO
}

struct ResySlotDateDTO: ResyDTOModel {
    let end: Date
    let start: Date
}

struct ResySlotConfigDTO: ResyDTOModel {
    let id: ResySlotID
    let type: ResySlotConfigType
}
