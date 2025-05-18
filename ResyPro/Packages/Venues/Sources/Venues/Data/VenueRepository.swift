//
//  VenueRepository.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import Network
import ProjectFoundation

public protocol VenueRepository: Sendable {
    func refreshAllVenues() async throws
}

public struct VenueRepositoryLive: VenueRepository {

    private let modelContainer: any ModelContainerProtocol
    private let networkService: any NetworkService
    private let venueMapper: any VenueMapper

    public init(
        modelContainer: any ModelContainerProtocol,
        networkService: any NetworkService = NetworkServiceLive(),
        venueMapper: any VenueMapper = VenueMapperLive()
    ) {
        self.modelContainer = modelContainer
        self.networkService = networkService
        self.venueMapper = venueMapper
    }

    public func refreshAllVenues() async throws {
        let getVenueEndpoint = GetAllVenuesEndpoint()
        let venueDTOs: [VenueDTO] = try await networkService.fetch(from: getVenueEndpoint)
        
        await MainActor.run {
            for venueDTO in venueDTOs {
                let venue = venueMapper.map(dto: venueDTO)
                modelContainer.mainContext.insert(venue)
            }

            try? modelContainer.mainContext.save()
        }
    }
}
