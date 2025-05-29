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
import ProjectFoundation


struct MainTabView: View {
    @State private var selectedTab: Tab = .schedueleReservation
    @Environment(UserSession.self) var userSession

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                ScheduleReservationHomeView()
                    .tabItem {
                        Image(systemName: "calendar")
                    }
                    .tag(Tab.schedueleReservation)

                SchedueleNotificationView()
                .tabItem {
                    Image(systemName: "bell")
                }
                .tag(Tab.schedueleNotification)

                AvailableReservationsContainerView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                    .tag(Tab.browse)

                ProfileView()
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
    MainTabView()
}

struct BrowseView: View {
    var body: some View {
        Text("Coming Soon")
    }
}

struct SchedueleNotificationView: View {
    @Environment(\.projectModelContainer) private var modelContainer: any ModelContainerProtocol
    @Query(sort: \Venue.name) var venues: [Venue]
    @Environment(UserSession.self) var userSession

    private var repository: any NotificationRepository {
        NotificationRepositoryLive(
            networkService: BearerNetworkServiceComposer.make(
                userSession: userSession
            ),
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

struct AvailableReservationsContainerView: View {
    @Environment(\.projectModelContainer) private var modelContainer: any ModelContainerProtocol
    @Query(sort: \Venue.name) var venues: [Venue]
    @Environment(UserSession.self) var userSession

    private var repository: any AvailableReservationsRepository {
        AvailableReservationsRepositoryLive(
            networkService: BearerNetworkServiceComposer.make(
                userSession: userSession
            ),
            mapper: AvailableReservationResponseMapperLive(),
            store: AvailableReservationsStoreLive(current: [])
        )
    }

    var body: some View {
        AvailableReservationsView(
            viewModel: AvailableReservationsView.ViewModel(
                allVenues: venues,
                repository: repository
            )
        )
    }
}
