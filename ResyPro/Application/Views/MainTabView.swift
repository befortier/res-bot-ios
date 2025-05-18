//
//  MainTabView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import SwiftData

struct MainTabView: View {
    @State private var selectedTab: Tab
    private let appState: AppState

    enum Tab: CaseIterable {
        case schedueleReservation

        case schedueleNotification

        case browse

        case profile
    }

    init(appState: AppState) {
        self._selectedTab = State(wrappedValue: .schedueleReservation)
        self.appState = appState
    }

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                SchedueleReservationHomeView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                    .tag(Tab.schedueleReservation)

                SchedueleNotificationView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                    .tag(Tab.schedueleNotification)

                AvailableReservationsView(viewModel: .init())
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                    .tag(Tab.browse)

                ProfileView(user: appState.user)
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
    MainTabView(appState: .stub())
}



struct BrowseView: View {
    var body: some View {
        Text("Coming Soon")
    }
}

import Venues
import Notifications

struct SchedueleNotificationView: View {
    @Query(sort: \Venue.name) var venues: [Venue]

    var body: some View {
        BulkNotificationFlowView(
            viewModel: BulkNotificationFlowViewModel(
                allVenues: venues,
                submitter: { request in
                    return NotificationSubmissionResponse(
                        interval: request.interval,
                        results: []
                    )
                }
            )
        )
    }
}

/*
 TODO:

 1. Resy Config update [Can be manual right now]

 1. POST /create-reservation-request
    / Sets AWS EventBridge
    / Creates Dynamo Entry
    / Event Bridge -> Schedueles ->
    / Takes in, schedueles cron-job, writes to in memory result
 2. GET /reservation-result
    / reads from in memory
 */
