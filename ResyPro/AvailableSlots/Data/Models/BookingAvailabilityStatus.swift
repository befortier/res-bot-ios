//
//  BookingAvailabilityStatus.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

enum BookingAvailabilityStatus: Int, RawRepresentable, ResyDTOModel {
    case available = 3
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let intValue = try container.decode(Int.self)
        self = BookingAvailabilityStatus(rawValue: intValue) ?? .unknown
    }
}
