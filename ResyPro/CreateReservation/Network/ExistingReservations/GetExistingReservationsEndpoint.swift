//
//  GetExistingReservationsEndpoint.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

struct ExistingReservationEndpoint: GetEndpoint {
    let baseURL: BaseURL = .resy
    let authToken: String

    let path = "/3/user/reservations"
    var queryParameters: [String: String]? {
        ["limit": "10", "offset": "1", "type": "upcoming"]
    }
    

    var headers: [String: String]? {
        HeaderProvider().commonHeaders(authToken: authToken)
    }
}

