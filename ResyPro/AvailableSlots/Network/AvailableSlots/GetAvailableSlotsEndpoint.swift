//
//  GetAvailableSlotsEndpoint.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

struct GetAvailableSlotsEndpoint: GetEndpoint {
    let baseURL: BaseURL = .resy
    let request: GetAvailableSlotsRequest
    let path = "/4/find"
    
    var queryParameters: [String: String]? {
        [
            "lat": "0",
            "long": "0",
            "day": request.date,
            "party_size": request.partySize,
            "venue_id": request.venueID
        ]
    }

    var headers: [String: String]? {
        HeaderProvider().commonHeaders()
    }

    let fixturesPath: String? = "available_slots_response_fixture"
}
