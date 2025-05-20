//
//  CheckAvailableReservationsRequest.swift
//  ResyPro
//
//  Created by OpenAI on 6/25/24.
//

import Foundation

struct CheckAvailableReservationsRequest: Sendable, Encodable {
	let interval: DateInterval
	let partySizeRange: ClosedRange<Int>
	let venueIDs: [Int]

	init(interval: DateInterval, partySizeRange: ClosedRange<Int>, venueIDs: [Int]) {
		self.interval = interval
		self.partySizeRange = partySizeRange
		self.venueIDs = venueIDs
	}
}
