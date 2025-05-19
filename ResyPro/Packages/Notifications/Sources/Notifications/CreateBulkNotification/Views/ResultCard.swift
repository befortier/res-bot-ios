//
//  ResultCard.swift
//  Notifications
//
//  Created by Ben Fortier on 5/18/25.
//

import DesignSystem
import SwiftUI
import Venues

struct ResultCard: View {
    let entry: NotificationSubmissionResponse.ResultEntry
    let venue: Venue?

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(venue?.name ?? "Venue \(entry.request.venueID)")
                    .font(.design(.headline))

                Text("Party size \(entry.request.partySize)")
                    .font(.design(.subheadline))

                if let intervalString = DateIntervalFormatter.short.string(from: entry.request.interval) {
                    Text(intervalString)
                        .font(.design(.footnote))
                        .foregroundStyle(Color.textSecondary)
                }
            }

            Spacer()

            Image(systemName: entry.success ? "checkmark.circle" : "xmark.circle")
                .foregroundColor(entry.success ? .green : .red)
        }
        .padding()
        .cardStyle()
    }
}
