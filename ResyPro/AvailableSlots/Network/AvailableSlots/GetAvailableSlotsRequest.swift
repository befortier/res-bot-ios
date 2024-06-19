//
//  GetAvailableSlotsRequest.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

struct GetAvailableSlotsRequest: Sendable, Equatable {
    let date: String
    let partySize: String
    let venueID: ResyVenueID
}
