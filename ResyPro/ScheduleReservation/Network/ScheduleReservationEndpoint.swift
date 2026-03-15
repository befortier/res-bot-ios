//
//  ScheduleReservationEndpoint.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/20/24.
//

import Foundation
import NetworkKit
import User
import Venues

struct ScheduleReservationEndpoint: PostEndpoint {
    let baseURL: BaseURL = .backend
    let request: GetAvailableSlotsRequest
    let requestBody: ScheduleReservationRequestBody?

    let path = "TBD"

    var queryParameters: [String: String]?
    var headers: [String: String]?
}

struct ScheduleReservationRequestBody: Codable, Identifiable {
    let id: String
    let userID: User.ID
    let venueID: Venue.ID
    let createdAt: Date
    let acceptedDateInterval: DateInterval
    let bookDate: Date
    let partySize: Int
    let behavior: ScheduelingBehavior
}
