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
        ForEach(result.results, id: \.venueID) { entry in
          HStack {
            Text("Venue ID: \(entry.venueID)")
            Spacer()
            Image(systemName: entry.succeeded ? "checkmark.circle" : "xmark.circle")
              .foregroundColor(entry.succeeded ? .green : .red)
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
      interval: DateInterval(start: .now, duration: 3600),
      results: [
        .init(venueID: 1, partySize: 2, succeeded: true),
        .init(venueID: 2, partySize: 4, succeeded: false),
      ]
    )
  )
}
