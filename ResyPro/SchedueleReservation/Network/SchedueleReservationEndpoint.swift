//
//  SchedueleReservationEndpoint.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/20/24.
//

import Foundation
import Network
import User
import Venues

struct SchedueleReservationEndpoint: PostEndpoint {
    let baseURL: BaseURL = .backend
    let request: GetAvailableSlotsRequest
    let requestBody: SchedueleReservationRequestBody?

    let path = "TBD"

    var queryParameters: [String: String]?
    var headers: [String: String]?
}

struct SchedueleReservationRequestBody: Codable, Identifiable {
    let id: String
    let userID: User.ID
    let venueID: Venue.ID
    let createdAt: Date
    let acceptedDateInterval: DateInterval
    let bookDate: Date
    let partySize: Int
    let behavior: ScheduelingBehavior
}
