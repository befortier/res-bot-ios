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
        ForEach(result.results.indices, id: \.self) { index in
          let entry = result.results[index]
          HStack {
            Text("Venue \(entry.request.venueID) • seats: \(entry.request.numSeats)")
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

#Preview {
  SubmissionResultView(
    result: NotificationSubmissionResponse(
      results: [
        .init(
          request: .init(
            venueID: 1,
            day: "2025-01-01",
            timePreferredStart: "10:00:00",
            timePreferredEnd: "11:00:00",
            numSeats: 2,
            serviceTypeID: 2
          ),
          success: true
        ),
        .init(
          request: .init(
            venueID: 2,
            day: "2025-01-01",
            timePreferredStart: "10:00:00",
            timePreferredEnd: "11:00:00",
            numSeats: 4,
            serviceTypeID: 2
          ),
          success: false
        )
      ]
    )
  )
}
