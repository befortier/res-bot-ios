//
//  NotificationTicket.swift
//  Notifications
//
//  Created by Ben Fortier on 5/30/25.
//

public import Foundation
public import ProjectFoundation
public import Venues

/// The request details originally sent to the server.
public struct NotificationTicket: Hashable, Sendable, Codable {
    @CodableDateInterval public var interval: DateInterval
    public let partySize: Int
    public let venueID: Venue.ID

    enum CodingKeys: String, CodingKey {
        case interval
        case partySize
        case venueID = "venue_id"
    }
}
