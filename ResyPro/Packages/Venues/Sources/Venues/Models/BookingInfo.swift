//
//  BookingInfo.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData

@Model
public final class BookingInfo: Equatable {
    public var time: String
    public var daysOut: Int
    @Relationship public var venue: Venue?

    public init(
        time: String,
        daysOut: Int
    ) {
        self.time = time
        self.daysOut = daysOut
    }

    public init?(bookingInfoDTO: BookingInfoDTO?) {
        guard let bookingInfoDTO else { return nil }
        self.time = bookingInfoDTO.time
        self.daysOut = bookingInfoDTO.daysOut
    }
}
