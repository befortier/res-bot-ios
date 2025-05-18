//
//  VerticalVenueCardGridView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI

/// A grid of vertical venue cards in two columns.
public struct VerticalVenueCardGridView<Card: View>: View {
  public typealias ActionHandler = @MainActor (VerticalVenueCard.ViewState) -> Void
  public typealias CardViewBuilder = @MainActor (VerticalVenueCard.ViewState) -> Card
  private let items: [VerticalVenueCard.ViewState]
  @ViewBuilder private let cardView: CardViewBuilder

  public init(
    venues: [Venue],
    @ViewBuilder cardView: @escaping CardViewBuilder,
  ) {
    self.items = venues.map {
      VerticalVenueCard.ViewState(venue: $0)
    }
    self.cardView = cardView
  }

  public var body: some View {
    LazyVGrid(
      columns: [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
      ],
      spacing: 16
    ) {
      ForEach(items) { item in
        cardView(item)
      }
    }
  }
}

#Preview {
  VerticalVenueCardGridView(venues: [.laserWolf]) { viewState in
    VerticalVenueCard(viewState: viewState)
      .frame(height: 200)
  }
  .padding()
}
