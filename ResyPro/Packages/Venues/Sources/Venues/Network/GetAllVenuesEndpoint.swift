//
//  GetAllVenuesEndpoint.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import Network

/// A struct defined in the Venues module.
struct GetAllVenuesEndpoint: GetEndpoint {
    let baseURL: BaseURL = .backend
    let path: String = "/venue/all"
    let queryParameters: [String : String]? = nil
    let headers: [String : String]? = nil

    
    let fixturesPath: String? = "venues_fixture"
}
