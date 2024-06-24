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
    @State private var selectedTab = Tab.allCases.first
    @Environment(\.modelContext) var modelContext: ModelContext
    @Environment(\.user) var user: User
    @Environment(\.resyConfig) var resyConfig: ResyConfig

    enum Tab: CaseIterable {
        case schedueleReservation

        case schedueleNotification

        case browse
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
                    .tag(Tab.schedueleReservation)

                AvailableReservationsView(viewModel: .init())
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                    .tag(Tab.browse)

            }
            .background(.white)
        }
    }
}


#Preview {
    MainTabView()
        .setAppState(.stub())
}



struct BrowseView: View {
    var body: some View {
        Text("Coming Soon")
    }
}

struct SchedueleNotificationView: View {
    var body: some View {
        Text("Coming Soon")
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
