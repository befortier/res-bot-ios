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

    var venue: Venue
    var createdAt: Date
    var acceptedDateInterval: DateInterval
    var bookDate: Date
    var partySize: Int
    var status: SchedueledReservationStatus
    var scheduelingBehavior: ScheduelingBehavior

    init(
        id: String,
        venue: Venue,
        createdAt: Date,
        acceptedDateInterval: DateInterval,
        bookDate: Date,
        partySize: Int,
        scheduelingBehavior: ScheduelingBehavior
    ) {
        self.id = id
        self.venue = venue
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

enum ScheduelingBehavior: String, Sendable, Codable {
    case slowAndSmooth = "safe"
    case riskyButFast = "risky"
}
