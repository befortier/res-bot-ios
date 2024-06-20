//
//  SupportedRestaurantsView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct SupportedRestaurantsView<Card: View>: View {
    @EnvironmentObject var supportedRestaurantStore: SupportedRestaurantStoreLive
    let viewModel: ViewModel
    let cardView: (SupportedRestaurant) -> Card

    var body: some View {
        if let supportedRestaurants = supportedRestaurantStore.current {
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(supportedRestaurants) { supportedRestaurant in
                        cardView(supportedRestaurant)
                    }
                }
            }
        } else {
            DefaultProgressView()
                .task { try? await viewModel.refreshSupportedRestaurants() }
        }
    }
}

extension SupportedRestaurantsView {
    struct ViewModel {

        private let supportedRestaurantStore: any SupportedRestaurantStore
        private let supportedRestaurantRepository: any SupportedRestaurantRepository

        init(supportedRestaurantStore: any SupportedRestaurantStore) {
            self.supportedRestaurantStore = supportedRestaurantStore
            self.supportedRestaurantRepository = SupportedRestaurantRepositoryLive(store: supportedRestaurantStore)
        }

        func refreshSupportedRestaurants() async throws {
            try await supportedRestaurantRepository.refreshSupportedStores()
        }
    }
}


