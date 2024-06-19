//
//  ReservationResponse.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

struct ReservationResponse: Codable, Sendable {
    let success: Bool
    let message: String?
}
