//
//  SchedueleReservationHomeView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import Venues

struct SchedueleReservationHomeView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var selectedVenue: Venue?

    var body: some View {
        VStack {
            SchedeuledReservationsCarouselView()
            Spacer()

            self.venuesListView
            .navigationTitle("Reserve your reservation")
            Spacer()
        }
    }

    @MainActor
    private var venuesListView: some View {
        VenuesListView(
            viewModel: VenuesListView.ViewModel(modelContext: modelContext),
            cardView: { venue in
                NavigationLink(destination: SchedueleReservationFormView(viewModel: .init(venue: venue))) {
                    VenueCard(venue: venue)
                        .padding(.horizontal, 16)
                }
            }
        )
    }
}
