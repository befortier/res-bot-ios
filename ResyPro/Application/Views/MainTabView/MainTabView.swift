//
//  MainTabView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Authentication
import Foundation
import NetworkKit
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
        TabView(selection: $selectedTab) {
            NavigationStack {
                ScheduleReservationHomeView()
            }
            .tabItem {
                Image(systemName: "calendar")
            }
            .tag(Tab.schedueleReservation)

            NavigationStack {
                SchedueleNotificationView()
            }
            .tabItem {
                Image(systemName: "bell")
            }
            .tag(Tab.schedueleNotification)

            NavigationStack {
                AvailableReservationsContainerView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
            }
            .tag(Tab.browse)

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person.crop.circle")
            }
            .tag(Tab.profile)

        }
        .background(.white)
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
            venueStore: VenueStoreLive(container: modelContainer),
            notificationsStore: NotificationsStoreLive(container: modelContainer)
        )
    }

    var body: some View {
        NotificationListView(
            venues: venues,
            repository: repository
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
