//
//  SchedueleReservationHomeView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import Venues
import ProjectFoundation
import User
import Network

struct SchedueleReservationHomeView: View {
    @Environment(\.projectModelContainer) private var modelContainer: any ModelContainerProtocol
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var selectedVenue: Venue?
    let user: User
    let resyConfig: ResyConfig

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
        VenueCardListView(
            viewModel: VenueCardListView.ViewModel(
                venueRepository: VenueRepositoryLive(
                    modelContainer: modelContainer,
                    networkService: BearerNetworkServiceComposer.make(
                        configuration: ResyHeaderConfiguration(
                            bearerToken: user.id,
                            resyAuthToken: resyConfig.authToken
                        )
                    )
                )
            )
        ) { venue in
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
