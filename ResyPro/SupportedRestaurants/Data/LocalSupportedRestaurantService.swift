//
//  LocalSupportedRestaurantService.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

protocol SupportedRestaurantService: Sendable {
    func getSupportedRestaurants() async throws -> [SupportedRestaurant]
}

struct LocalSupportedRestaurantService: SupportedRestaurantService {
    private let decoder = JSONDecoder()

    enum FileError: Error {
        case notFound
    }

    func getSupportedRestaurants() async throws -> [SupportedRestaurant] {
        guard let url = Bundle.main.url(forResource: "Restaurants", withExtension: "json") else {
            throw FileError.notFound
        }

        let data = try Data(contentsOf: url)
        return try decoder.decode([SupportedRestaurant].self, from: data)
    }
}
