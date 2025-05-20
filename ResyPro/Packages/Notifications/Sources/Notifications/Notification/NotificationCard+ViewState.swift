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
		public let partySize: Int
		public let interval: DateInterval

		public init(
			venueName: String,
			venueID: Int,
			partySize: Int,
			interval: DateInterval
		) {
			self.venueName = venueName
			self.venueID = venueID
			self.partySize = partySize
			self.interval = interval
		}

		public init(request: NotificationTicket, venue: Venue?) {
			self.init(
				venueName: venue?.name ?? "Venue \(request.venueID)",
				venueID: request.venueID,
				partySize: request.partySize,
				interval: request.interval
			)
		}
	}
}
