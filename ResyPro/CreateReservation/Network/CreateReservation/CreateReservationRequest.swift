//
//  CreateReservationRequest.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

struct ReservationRequest: Codable, Sendable {
    let venueID: String
    let date: String
    let time: String
    let partySize: Int
    let paymentID: String
    let authToken: String
}
