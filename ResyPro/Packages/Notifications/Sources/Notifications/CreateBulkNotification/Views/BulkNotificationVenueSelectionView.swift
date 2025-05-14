//
//  BulkNotificationVenueSelectionView.swift
//  Notifications
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI
import DesignSystem
import Venues

public struct BulkNotificationVenueSelectionView: View {
    let allVenues: [Venue]
    @Binding var selectedVenueIDs: Set<Int>
    let dateInterval: DateInterval
    let partySizeRange: ClosedRange<Int>
    let onSubmit: () -> Void

    public init(
        allVenues: [Venue],
        selectedVenueIDs: Binding<Set<Int>>,
        dateInterval: DateInterval,
        partySizeRange: ClosedRange<Int>,
        onSubmit: @escaping () -> Void
    ) {
        self.allVenues = allVenues
        self._selectedVenueIDs = selectedVenueIDs
        self.dateInterval = dateInterval
        self.partySizeRange = partySizeRange
        self.onSubmit = onSubmit
    }

    public var body: some View {
        VStack(spacing: .zero) {
            VStack(spacing: 4) {
                Text("\(selectedVenueIDs.count) venue\(selectedVenueIDs.count == 1 ? "" : "s") selected")
                    .font(.design(.headline))
                    .foregroundStyle(Color.textPrimary)

                Text("\(formattedDate) • Party size \(partySizeRange.lowerBound)–\(partySizeRange.upperBound)")
                    .font(.design(.subheadline))
                    .foregroundStyle(Color.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color.white)

            Divider()
                .padding(.bottom, 16)

            VenueSelectionView(
                allVenues: allVenues,
                selectedVenueIDs: $selectedVenueIDs,
                onSubmit: onSubmit
            )
        }
    }

    private var formattedDate: String {
        DateIntervalFormatter.short.string(from: dateInterval) ?? ""
    }
}
