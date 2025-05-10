//
//  BookingInfo.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/27/24.
//

import Foundation
import SwiftData

@Model
final class BookingInfo: Equatable {
    var time: String
    var daysOut: Int
    @Relationship var venue: Venue?

    init(
        time: String,
        daysOut: Int
    ) {
        self.time = time
        self.daysOut = daysOut
    }

    init?(bookingInfoDTO: BookingInfoDTO?) {
        guard let bookingInfoDTO else { return nil }
        self.time = bookingInfoDTO.time
        self.daysOut = bookingInfoDTO.daysOut
    }
}
