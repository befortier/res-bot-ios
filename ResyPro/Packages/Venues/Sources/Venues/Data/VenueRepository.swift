//
//  VenueRepository.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import NetworkKit

/// Persists venue data using the provided dependencies.
public protocol VenueRepository: Sendable {
	/// Refreshes all venues from the backend into storage.
	func refreshAllVenues() async throws
}

/// Default ``VenueRepository`` implementation.
public struct VenueRepositoryLive: VenueRepository {

	private let venueStore: any VenueStore
	private let networkService: any NetworkService
	private let venueMapper: any VenueMapper

	public init(
	  venueStore: any VenueStore,
	  networkService: any NetworkService,
	  venueMapper: any VenueMapper = VenueMapperLive()
	) {
	  self.venueStore = venueStore
	  self.networkService = networkService
	  self.venueMapper = venueMapper
	}

	public func refreshAllVenues() async throws {
	  let getVenueEndpoint = GetAllVenuesEndpoint()
	  let venueDTOs: [VenueDTO] = try await networkService.fetch(from: getVenueEndpoint)

	  await MainActor.run {
	    for venueDTO in venueDTOs {
	      let venue = venueMapper.map(dto: venueDTO)
	      try? venueStore.saveIfNeeded(venue)
	    }
	  }
	}
}
