//
//  GetAllVenuesEndpoint.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

struct GetAllVenuesEndpoint: GetEndpoint {
    let baseURL: BaseURL = .backend
    let path: String = "/venue/all"
    let queryParameters: [String : String]? = nil
    let headers: [String : String]? = nil
}
