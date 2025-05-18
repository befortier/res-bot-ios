//
//  SelectableVenueCard.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import DesignSystem
import NukeUI
import SwiftUI

/// Card used in selection lists that displays a venue and selection state.
public struct SelectableVenueCard: View {
  let venueCardViewState: VerticalVenueCard.ViewState
  let isSelected: Bool

  public var body: some View {
    VerticalVenueCard(viewState: venueCardViewState)
      .overlay {
        ZStack(alignment: .bottomTrailing) {
          if isSelected {
            Image(systemName: "checkmark.circle.fill")
              .foregroundColor(.green)
              .padding(4)
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color.green, lineWidth: 1)
            Color.green.opacity(0.02)
          }
        }
      }
  }
}

#Preview {
  VStack {
    SelectableVenueCard(
      venueCardViewState: .init(venue: .laserWolf),
      isSelected: true
    )
    .frame(height: 200)
    SelectableVenueCard(
      venueCardViewState: .init(venue: .laserWolf),
      isSelected: false
    )
    .frame(height: 200)
  }
}
