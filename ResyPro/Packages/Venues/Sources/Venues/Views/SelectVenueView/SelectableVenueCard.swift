//
//  SelectableVenueCard.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI
import DesignSystem
import NukeUI

public struct SelectableVenueCard: View {
    let venueCardViewState: VerticalVenueCard.ViewState
    let isSelected: Bool

    public var body: some View {
        VerticalVenueCard(viewState: venueCardViewState)
            .overlay(alignment: .bottomTrailing) {
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .padding(4)
                }
            }
            .overlay {
                isSelected ? Color.green.opacity(0.02) : nil
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
