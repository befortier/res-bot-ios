//
//  Resy+TypeAlias.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

// MARK: - Decoding Model

typealias ResyDTOModel = Sendable & Decodable

// MARK: - ID

typealias ResySlotID = String
typealias ResyVenueID = String

// MARK: - Token

typealias ResyBookingToken = String
typealias ResyAuthToken = String
