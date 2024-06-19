//
//  AvailableReservation.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

struct AvailableReservation: Sendable, Equatable, Identifiable {
    let slotID: ResySlotID
    let time: Date
    let bookingAvailabilityStatus: BookingAvailabilityStatus

    var id: ResySlotID { slotID }
}
