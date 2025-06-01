//
//  SubmissionResultView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import DesignSystem
import ProjectFoundation
import SwiftUI
import Venues

/// Displays submission results as they arrive from the websocket stream.
public struct SubmissionResultView: View {
    /// The list of entries received so far.
    let results: [NotificationSubmissionResponse.ResultEntry]
    /// The total number of results expected, if known.
    let expectedCount: Int?
    /// Indicates whether the server is still processing results.
    let isLoading: Bool
    /// Lookup table of venues keyed by venue id.
    let venuesByID: [Int: Venue]
    /// Called when the user continues after processing completes.
    let onContinue: () -> Void

    public init(
        results: [NotificationSubmissionResponse.ResultEntry],
        expectedCount: Int?,
        isLoading: Bool,
        venuesByID: [Int: Venue],
        onContinue: @escaping () -> Void
    ) {
        self.results = results
        self.expectedCount = expectedCount
        self.isLoading = isLoading
        self.venuesByID = venuesByID
        self.onContinue = onContinue
    }

    private var mergedResults: [(MergedVenueTicket, NotificationCardStyle)] {
        let grouped = Dictionary(grouping: results) { $0.request.venueID }
        return grouped.values.compactMap { entries in
            guard let merged = VenueTicketMerger.merge(entries.map { $0.request }).first else { return nil }
            let style: NotificationCardStyle = entries.allSatisfy(\.success) ? .success : .fail
            return (merged, style)
        }
        .sorted { $0.0.interval.start < $1.0.interval.start }
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Notifications Created")
                    .font(.design(.title))

                ForEach(mergedResults, id: \.0.venueID) { merged, style in
                    NotificationCard(
                        viewState: .init(
                            venueName: venuesByID[merged.venueID]?.name ?? "Venue \(merged.venueID)",
                            venueID: merged.venueID,
                            partySizes: merged.partySizes,
                            interval: merged.interval,
                            venueImageURL: venuesByID[merged.venueID]?.images.first
                        )
                    )
                    .NotificationCardStyle(style)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                if let expectedCount, results.count >= expectedCount {
                    Text("All notifications processed")
                        .font(.design(.subheadline))
                        .foregroundStyle(Color.textSecondary)
                } else if isLoading {
                    ProgressView()
                }

                Button("Continue") {
                    onContinue()
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(isLoading || (expectedCount != nil && results.count < (expectedCount ?? 0)))
            }
            .padding()
            .animation(.default, value: results)
        }
    }
}

