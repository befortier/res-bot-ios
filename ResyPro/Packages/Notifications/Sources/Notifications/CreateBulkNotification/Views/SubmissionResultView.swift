//
//  SubmissionResultView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import DesignSystem
import SwiftUI

/// Displays the results of submitting a bulk notification request.
public struct SubmissionResultView: View {
    let result: NotificationSubmissionResponse?

    public var body: some View {
        VStack(spacing: 16) {
            Text("Notifications Created")
                .font(.design(.title))
            if let result {
                ForEach(Array(result.results.enumerated()), id: \.offset) { index, entry in
                    HStack {
                        Text("Venue \(entry.request.venueID) • seats: \(entry.request.partySize)")
                        Spacer()
                        Image(systemName: entry.success ? "checkmark.circle" : "xmark.circle")
                            .foregroundColor(entry.success ? .green : .red)
                    }
                }
            }
        }
        .padding()
    }
}
