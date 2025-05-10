//
//  VenueRepository.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

protocol VenueRepository: Sendable {
    func refreshAllVenues() async throws
}

struct VenueRepositoryLive: VenueRepository {

    private let modelContext: any ModelContextProtocol
    private let networkService: any NetworkService
    private let venueMapper: any VenueMapper

    init(
        modelContext: any ModelContextProtocol,
        networkService: any NetworkService = NetworkServiceLive(),
        venueMapper: any VenueMapper = VenueMapperLive()
    ) {
        self.modelContext = modelContext
        self.networkService = networkService
        self.venueMapper = venueMapper
    }

    func refreshAllVenues() async throws {
        let getVenueEndpoint = GetAllVenuesEndpoint()
        let venueDTOs: [VenueDTO] = try await networkService.fetch(from: getVenueEndpoint)

        for venueDTO in venueDTOs {
            let venue = venueMapper.map(dto: venueDTO)
            await modelContext.insert(venue)
        }
    }
}

