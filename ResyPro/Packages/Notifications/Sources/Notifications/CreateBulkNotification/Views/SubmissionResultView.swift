//
//  SubmissionResultView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import DesignSystem
import SwiftUI

/// Displays submission results as they arrive from the websocket stream.
public struct SubmissionResultView: View {
  /// The list of entries received so far.
  let results: [NotificationSubmissionResponse.ResultEntry]
  /// The total number of results expected, if known.
  let expectedCount: Int?

  public var body: some View {
    VStack(spacing: 16) {
      Text("Notifications Created")
        .font(.design(.title))

      ForEach(Array(results.enumerated()), id: \.offset) { _, entry in
        HStack {
          Text("Venue \(entry.request.venueID) • seats: \(entry.request.partySize)")
          Spacer()
          Image(systemName: entry.success ? "checkmark.circle" : "xmark.circle")
            .foregroundColor(entry.success ? .green : .red)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
      }

      if let expectedCount, results.count >= expectedCount {
        Text("All notifications processed")
          .font(.design(.subheadline))
          .foregroundStyle(Color.textSecondary)
      } else {
        ProgressView()
      }
    }
    .padding()
    .animation(.default, value: results)
  }
}
