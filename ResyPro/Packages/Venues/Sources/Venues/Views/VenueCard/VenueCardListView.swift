//
//  VenueCardListView.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import SwiftData
import DesignSystem
import ProjectFoundation

/// A struct defined in the Venues module.
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
                    VStack(spacing: 24) {
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
    public struct ViewModel: Sendable {
        private let venueRepository: any VenueRepository

        public init(modelContext: any ModelContextProtocol) {
            self.venueRepository = VenueRepositoryLive(modelContext: modelContext)
        }

        func refreshAllVenues() async throws {
            try await venueRepository.refreshAllVenues()
        }
    }
}
