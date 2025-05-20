//
//  NotificationCard.swift
//  Notifications
//
//  Created by Ben Fortier on 5/18/25.
//

import DesignSystem
import SwiftUI
import Venues

/// Displays information about a notification request.
public struct NotificationCard: View {
    /// Visual style for the card.
    @Environment(\.notificationStyle) private var style: NotificationStyle

    /// Details of the request the notification represents.
    public let request: NotificationTicket
    /// Optional venue associated with the request.
    public let venue: Venue?

    /// Creates a notification card.
    public init(
        request: NotificationTicket,
        venue: Venue?
    ) {
        self.request = request
        self.venue = venue
    }

    public var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(venue?.name ?? "Venue \(request.venueID)")
                    .font(.design(.headline))

                Text("Party size \(request.partySize)")
                    .font(.design(.subheadline))

                if let intervalString = DateIntervalFormatter.short.string(from: request.interval) {
                    Text(intervalString)
                        .font(.design(.footnote))
                        .foregroundStyle(Color.textSecondary)
                }
            }

            Spacer()

            Image(systemName: style == .fail ? "xmark.circle" : "checkmark.circle")
                .notificationStyle(style)
        }
        .padding()
        .cardStyle()
    }
}
