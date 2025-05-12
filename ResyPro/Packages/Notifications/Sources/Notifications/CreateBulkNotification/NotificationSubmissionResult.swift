//
//  NotificationSubmissionResult.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import Foundation

/// The result of a bulk reservation notification submission.
public struct NotificationSubmissionResult: Equatable, Sendable {
    /// The date interval requested by the user.
    public let interval: DateInterval

    /// Results of the submission attempt for each venue.
    public let results: [VenueResult]

    public struct VenueResult: Equatable, Sendable {
        public let venueID: Int
        public let partySize: Int
        public let succeeded: Bool
    }

    public init(interval: DateInterval, results: [VenueResult]) {
        self.interval = interval
        self.results = results
    }
}
