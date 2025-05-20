//
//  ScheduledReservation.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData
import Venues

@Model
	final class ScheduledReservation: Identifiable, Equatable {
	@Attribute(.unique) var id: String
	
	var venue: Venue
	var createdAt: Date
	var acceptedDateInterval: DateInterval
	var bookDate: Date
	var partySize: Int
	var status: ScheduledReservationStatus
	var scheduelingBehavior: ScheduelingBehavior
	
	init(
	id: String,
	venue: Venue,
	createdAt: Date,
	acceptedDateInterval: DateInterval,
	bookDate: Date,
	partySize: Int,
	scheduelingBehavior: ScheduelingBehavior
	) {
	self.id = id
	self.venue = venue
	self.createdAt = createdAt
	self.acceptedDateInterval = acceptedDateInterval
	self.bookDate = bookDate
	self.partySize = partySize
	self.status = .scheduled
	self.scheduelingBehavior = scheduelingBehavior
	}
	}
	
	
	struct ScheduledReservationResult: Sendable, Codable {
	let timeExecuted: Date
	let timeFinished: Date
	let error: CodableError?
	}
	
	struct CodableError: Sendable, Codable, Equatable, Error {
	let code: Int
	let errorCode: Int
	let localizedDescription: String
	}
	
	enum ScheduledReservationStatus: Sendable, Codable {
	case scheduled
	case finished(ScheduledReservationResult)
	}
	
	enum ScheduelingBehavior: String, Sendable, Codable {
	case slowAndSmooth = "safe"
	case riskyButFast = "risky"
	}
