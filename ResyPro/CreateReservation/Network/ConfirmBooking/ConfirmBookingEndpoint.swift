//
//  ConfirmBookingEndpoint.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

struct ConfirmBookingEndpoint: PostEndpoint {
    
    let baseURL: BaseURL = .resy
    let authToken: String
    let requestBody: RequestBody?
    let path = "/3/book"
    var queryParameters: [String: String]? { nil }

    var headers: [String: String]? {
        var headers = HeaderProvider().commonHeaders(authToken: authToken)
        headers["content-type"] = "application/x-www-form-urlencoded"
        headers["origin"] = "https://widgets.resy.com"
        headers["referer"] = "https://widgets.resy.com/"
        return headers
    }
}

// MARK: - RequestBody

extension ConfirmBookingEndpoint {
    struct RequestBody: NetworkRequestBody {
        let paymentID: String
        let bookToken: String
        let sourceID: String = "resy.com-venue-details"

        enum CodingKeys: String, CodingKey {
            case paymentID = "struct_payment_method"
            case bookToken = "book_token"
            case sourceID = "source_id"
        }
    }
}
