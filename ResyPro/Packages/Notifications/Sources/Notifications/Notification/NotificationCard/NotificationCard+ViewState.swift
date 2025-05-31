//
//  NotificationCard+ViewState.swift
//  Notifications
//
//  Created by Ben Fortier on 5/18/25.
//

import Foundation
import Venues

extension NotificationCard {
	/// Data required to display a ``NotificationCard``.
	public struct ViewState: Hashable, Sendable {
		public let venueName: String
		public let venueID: Int
		public let partySizes: [Int]
		public let interval: DateInterval
        public let venueImageURL: URL?

		public init(
			venueName: String,
			venueID: Int,
            partySizes: [Int],
			interval: DateInterval,
            venueImageURL: URL?
		) {
			self.venueName = venueName
			self.venueID = venueID
			self.partySizes = partySizes
			self.interval = interval
            self.venueImageURL = venueImageURL
		}

		public init(request: NotificationTicket, venue: Venue?) {
			self.init(
				venueName: venue?.name ?? "Venue \(request.venueID)",
				venueID: request.venueID,
                partySizes: [request.partySize],
				interval: request.interval,
                venueImageURL: venue?.images.first
			)
		}
	}
}
