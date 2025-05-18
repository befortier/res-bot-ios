//
//  VerticalVenueCard.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import DesignSystem
import Nuke
import NukeUI
import SwiftUI

/// A vertically stacked venue card with circular image and centered content.
public struct VerticalVenueCard: View {
  private let viewState: ViewState

  public init(viewState: ViewState) {
    self.viewState = viewState
  }

  public var body: some View {
    GeometryReader { geo in
      VStack(spacing: .zero) {
        ResizableImage(url: viewState.imageURL)
          .frame(height: geo.size.height * 0.45)
          .clipped()

        VStack(spacing: 2) {
          Text(viewState.name)
            .font(.design(.headline))
            .foregroundStyle(Color.textPrimary)
            .padding(.bottom, 4)

          Text(viewState.cuisineType)
            .font(.design(.callout))
            .foregroundStyle(Color.textSecondary)
            .lineLimit(2)

          Text(viewState.neighborhood)
            .font(.design(.footnote))
            .foregroundStyle(Color.textSecondary)
        }
        .padding(12)
      }
    }
    .overlay(alignment: .bottomLeading) {
      Text(price: viewState.priceRange)
        .font(.design(.caption3))
        .foregroundStyle(Color.textSecondary)
        .padding(8)
    }
    .aspectRatio(0.85, contentMode: .fit)
    .cardStyle()
  }
}

// MARK: Prevew

#Preview {
  VerticalVenueCard(viewState: .init(venue: .laserWolf))
    .frame(height: 200)
}
