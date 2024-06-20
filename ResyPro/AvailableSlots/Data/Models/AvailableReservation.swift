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

// MARK: - Stub

extension Array<AvailableReservation> {
    static var stub: Self {
        let initialDate = Date(timeIntervalSince1970: 1719009000)
        let intArray: [Int] = [Int](0...50)
        return intArray.map { int in
            AvailableReservation(
                slotID: "\(int)",
                time: initialDate.advanced(by: 60 * 15 * Double(int)),
                bookingAvailabilityStatus: .available
            )
        }
    }
}
