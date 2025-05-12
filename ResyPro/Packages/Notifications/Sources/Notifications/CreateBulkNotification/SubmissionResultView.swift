//
//  SubmissionResultView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI
import DesignSystem

public struct SubmissionResultView: View {
    let result: NotificationSubmissionResult?

    public var body: some View {
        VStack(spacing: 16) {
            Text("Notifications Created")
                .font(.title)
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
