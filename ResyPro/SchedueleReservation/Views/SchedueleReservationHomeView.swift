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

    private var venuesListView: some View {
        VenueCardListView(viewModel: VenueCardListView.ViewModel(modelContext: modelContext)) { venue in
            NavigationLink(
                destination: DefaultVenueDetailsDestinationView(venue: venue)
            ) {
                HorizontalVenueCard(model: HorizontalVenueCardModel(venue: venue))
                    .padding(.horizontal, 16)
            }
        }
    }
}


struct DefaultVenueDetailsDestinationView: View {
    @State var showScheduleBotModal: Bool = false
    let venue: Venue

    var body: some View {
        VenueDetailsView(viewState: .init(venue: venue)) { action in
            switch action {
            case .notifyMe:
                break
            case .scheduleBot:
                showScheduleBotModal = true
            case .seeAvailability:
                break
            }
        }
        .sheet(isPresented: $showScheduleBotModal) {
            SchedueleReservationFormView(
                viewModel: .init(venue: venue)
            )
        }
    }
}
