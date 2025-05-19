//
//  SchedueleReservationHomeView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Authentication
import Foundation
import Network
import ProjectFoundation
import SwiftUI
import User
import Venues

struct SchedueleReservationHomeView: View {
  @Environment(\.projectModelContainer) private var modelContainer: any ModelContainerProtocol
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @Environment(\.tokenStore) private var tokenStore
  @State var selectedVenue: Venue?
  let user: User

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
          venueStore: VenueStoreLive(container: modelContainer),
          networkService: BearerNetworkServiceComposer.make(
            configuration: ResyHeaderConfiguration(user: user),
            refresher: AuthenticationRepositoryLive(
              networkService: NetworkServiceLive(),
              tokenStore: tokenStore
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
