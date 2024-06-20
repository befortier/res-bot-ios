//
//  SchedueledReservation.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData

@Model
final class SchedueledReservation: Identifiable, Equatable {
    @Attribute(.unique) var id: String

    var restaurant: SupportedRestaurant
    var createdAt: Date
    var acceptedDateInterval: DateInterval
    var bookDate: Date
    var partySize: Int
    var status: SchedueledReservationStatus
    var scheduelingBehavior: ScheduelingBehavior

    init(
        id: String,
        restaurant: SupportedRestaurant,
        createdAt: Date,
        acceptedDateInterval: DateInterval,
        bookDate: Date,
        partySize: Int,
        scheduelingBehavior: ScheduelingBehavior
    ) {
        self.id = id
        self.restaurant = restaurant
        self.createdAt = createdAt
        self.acceptedDateInterval = acceptedDateInterval
        self.bookDate = bookDate
        self.partySize = partySize
        self.status = .schedueled
        self.scheduelingBehavior = scheduelingBehavior
    }
}


struct SchedueledReservationResult: Sendable, Codable {
    let timeExecuted: Date
    let timeFinished: Date
    let error: CodableError?
}

struct CodableError: Sendable, Codable, Equatable, Error {
    let code: Int
    let errorCode: Int
    let localizedDescription: String
}

enum SchedueledReservationStatus: Sendable, Codable {
    case schedueled
    case finished(SchedueledReservationResult)
}

enum ScheduelingBehavior: Sendable, Codable {
    case slowAndSmooth
    case riskyButFast
}
