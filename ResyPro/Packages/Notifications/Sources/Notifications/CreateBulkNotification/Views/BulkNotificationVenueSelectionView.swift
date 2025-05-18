//
//  BulkNotificationVenueSelectionView.swift
//  Notifications
//
//  Created by Ben Fortier on 5/11/25.
//

import DesignSystem
import SwiftUI
import Venues

/// Displays a list of venues for the user to select before submitting a bulk notification request.
public struct BulkNotificationVenueSelectionView: View {
  let allVenues: [Venue]
  @Binding var selectedVenueIDs: Set<Int>
  let dateInterval: DateInterval
  let partySizeRange: ClosedRange<Int>
  let onSubmit: () -> Void

  /// Creates the venue selection view.
  /// - Parameters:
  ///   - allVenues: All venues that can be chosen.
  ///   - selectedVenueIDs: Binding to the set of currently selected venue IDs.
  ///   - dateInterval: The desired reservation interval to display in the header.
  ///   - partySizeRange: The desired party size range to display in the header.
  ///   - onSubmit: Called when the user finishes selecting venues.
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

        Text(
          "\(formattedDate) • Party size \(partySizeRange.lowerBound)–\(partySizeRange.upperBound)"
        )
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

#Preview {
  BulkNotificationVenueSelectionPreview()
}

private struct BulkNotificationVenueSelectionPreview: View {
  @State private var selected: Set<Int> = []

  var body: some View {
    BulkNotificationVenueSelectionView(
      allVenues: [Venue.laserWolf],
      selectedVenueIDs: $selected,
      dateInterval: DateInterval(start: .now, duration: 3600),
      partySizeRange: 2...4,
      onSubmit: {}
    )
  }
}
