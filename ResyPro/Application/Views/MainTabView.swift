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
    @State private var selectedTab = Tab.createReservation
    @Environment(\.modelContext) var modelContext: ModelContext
    @Environment(\.user) var user: User
    @Environment(\.resyConfig) var resyConfig: ResyConfig

    enum Tab {
        case createReservation

        case availableReservations
    }

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                CreateReservationView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                    .tag(Tab.createReservation)

                AvailableReservationsView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }
                    .tag(Tab.availableReservations)

            }
        }
    }
}


#Preview {
    MainTabView()
        .setAppState(.stub())
}
