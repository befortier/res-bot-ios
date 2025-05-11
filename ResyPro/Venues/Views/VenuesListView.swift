//
//  VenuesListView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import SwiftData
import DesignSystem

struct VenuesListView<Card: View>: View {
    @Query(sort: \Venue.name) var venues: [Venue]
    let viewModel: ViewModel
    let cardView: (Venue) -> Card

    var body: some View {
        Group {
            if !venues.isEmpty {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(venues) { venue in
                            cardView(venue)
                        }
                    }
                }
            } else {
                DefaultProgressView()
            }
        }
        .onChange(of: venues) { venues in
            print("HERE", venues.count)
        }
        .task {
            do {
                try await viewModel.refreshAllVenues()
            } catch {
                print(error)
            }
        }
    }
}

extension VenuesListView {
    struct ViewModel {
        private let venueRepository: any VenueRepository

        init(modelContext: any ModelContextProtocol) {
            self.venueRepository = VenueRepositoryLive(modelContext: modelContext)
        }

        func refreshAllVenues() async throws {
            try await venueRepository.refreshAllVenues()
        }
    }
}
