//
//  SupportedRestaurantRepository.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

protocol SupportedRestaurantRepository: Sendable {
    func refreshSupportedStores() async throws
}

struct SupportedRestaurantRepositoryLive: SupportedRestaurantRepository {

    private let store: any SupportedRestaurantStore
    private let service: any SupportedRestaurantService

    init(
        store: any SupportedRestaurantStore,
        service: any SupportedRestaurantService = LocalSupportedRestaurantService()
    ) {
        self.store = store
        self.service = service
    }

    func refreshSupportedStores() async throws {
        let supportedRestaurants = try await service.getSupportedRestaurants()
        await store.setCurrent(to: supportedRestaurants)
    }
}
