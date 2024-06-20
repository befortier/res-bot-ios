//
//  SupportedRestaurant.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

struct SupportedRestaurant: Codable, Sendable, Identifiable {
    let id: Int
    let name: String
    let reservation: String?
}
