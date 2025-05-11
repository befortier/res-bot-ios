//
//  VenueRepository.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import Network

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
        
        await MainActor.run {
            for venueDTO in venueDTOs {
                let venue = venueMapper.map(dto: venueDTO)
                modelContext.insert(venue)
            }

            try? modelContext.save()
        }
    }
}

