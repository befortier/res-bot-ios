//
//  MainTabView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Authentication
import Foundation
import Network
import Notifications
import SwiftData
import SwiftUI
import User
import Venues

struct MainTabView: View {
  @State private var selectedTab: Tab
  private let user: User
  @Environment(\.tokenStore) private var tokenStore

  enum Tab: CaseIterable {
    case schedueleReservation

    case schedueleNotification

    case browse

    case profile
  }

  init(user: User) {
    self._selectedTab = State(wrappedValue: .schedueleReservation)
    self.user = user
  }

  var body: some View {
    NavigationStack {
      TabView(selection: $selectedTab) {
        SchedueleReservationHomeView(user: user)
          .tabItem {
            Image(systemName: "calendar")
          }
          .tag(Tab.schedueleReservation)

        SchedueleNotificationView(
          networkService: BearerNetworkServiceComposer.make(
            configuration: ResyHeaderConfiguration(user: user),
            refresher: AuthenticationRepositoryLive(
              networkService: NetworkServiceLive(),
              tokenStore: tokenStore
            )
          )
        )
        .tabItem {
          Image(systemName: "bell")
        }
        .tag(Tab.schedueleNotification)

        AvailableReservationsView(viewModel: .init())
          .tabItem {
            Image(systemName: "magnifyingglass")
          }
          .tag(Tab.browse)

        ProfileView(user: user)
          .tabItem {
            Image(systemName: "person.crop.circle")
          }
          .tag(Tab.profile)

      }
      .background(.white)
    }
  }
}

#Preview {
  MainTabView(user: .stub)
}

struct BrowseView: View {
  var body: some View {
    Text("Coming Soon")
  }
}

struct SchedueleNotificationView: View {
  @Environment(\.projectModelContainer) private var modelContainer: any ModelContainerProtocol
  @Query(sort: \Venue.name) var venues: [Venue]
  private let networkService: any NetworkService

  init(networkService: any NetworkService) {
    self.networkService = networkService
  }

  private var repository: any NotificationRepository {
    NotificationRepositoryLive(
      networkService: networkService,
      venueStore: VenueStoreLive(container: modelContainer)
    )
  }

  var body: some View {
    BulkNotificationFlowView(
      viewModel: BulkNotificationFlowViewModel(
        allVenues: venues,
        submitter: { request in
          try await repository.submit(request)
        }
      )
    )
  }
}
