//
//  VenueCardListView.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import DesignSystem
import Foundation
import ProjectFoundation
import SwiftData
import SwiftUI

/// Displays a scrollable list of venue cards using a supplied card builder.
public struct VenueCardListView<Card: View>: View {
  @Query(sort: \Venue.name) var venues: [Venue]
  private let viewModel: ViewModel
  private let cardView: (Venue) -> Card

  public init(
    viewModel: ViewModel,
    cardView: @escaping (Venue) -> Card
  ) {
    self.viewModel = viewModel
    self.cardView = cardView
  }

  public var body: some View {
    Group {
      if !venues.isEmpty {
        ScrollView {
          LazyVStack(spacing: 24) {
            ForEach(venues) { venue in
              cardView(venue)
            }
          }
        }
      } else {
        DefaultProgressView()
      }
    }
    .task {
      try? await viewModel.refreshAllVenues()
    }
  }
}

extension VenueCardListView {
    /// Helper responsible for loading venue data.
    public struct ViewModel: Sendable {
        private let venueRepository: any VenueRepository

        public init(
            venueRepository:  any VenueRepository
        ) {
            self.venueRepository = venueRepository
        }

        func refreshAllVenues() async throws {
            do {
                try await venueRepository.refreshAllVenues()
            } catch {
                print("HERE", error)
            }
        }
    }
}
