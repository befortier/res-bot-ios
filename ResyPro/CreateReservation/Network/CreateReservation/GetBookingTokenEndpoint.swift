//
//  GetBookingTokenEndpoint.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import NetworkKit

struct GetBookingTokenEndpoint: GetEndpoint {
    let baseURL: BaseURL = .resy
    let date: String
    let partySize: String
    let slotID: String

    let path: String = "/3/details"
    var queryParameters: [String: String]? {
        [
            "day": date,
            "party_size": partySize,
            "config_id": slotID
        ]
    }

    var headers: [String: String]? {
        HeaderProvider.commonHeaders()
    }
}
