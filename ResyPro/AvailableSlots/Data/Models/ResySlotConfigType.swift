//
//  ResySlotConfigType.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

enum ResySlotConfigType: String, RawRepresentable, ResyDTOModel {
    case coveredPatio = "Covered Patio"
    case diningRoom = "Dining Room"
    case indoorDining = "Indoor Dining"
    case highTop = "High Top"
    case booth = "Booth"
    case diningHall = "Dining Hall"
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = ResySlotConfigType(rawValue: rawValue) ?? .unknown
    }
}
