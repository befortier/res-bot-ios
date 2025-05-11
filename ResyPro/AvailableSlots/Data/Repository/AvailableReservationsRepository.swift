//
//  AvailableReservationsRepository.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import Network

protocol AvailableReservationsRepository: Sendable {
    func refreshAvailableReservations(request: GetAvailableSlotsRequest) async throws
}

struct AvailableReservationsRepositoryLive: AvailableReservationsRepository {

    private let networkService: any NetworkService
    private let store: any AvailableReservationsStore
    private let mapper: any AvailableReservationResponseMapper

    init(
        networkService: any NetworkService = NetworkServiceLive(jsonDecoder: .availableReservationDecoder),
        mapper: any AvailableReservationResponseMapper = AvailableReservationResponseMapperLive(),
        store: any AvailableReservationsStore
    ) {
        self.networkService = networkService
        self.mapper = mapper
        self.store = store
    }

    func refreshAvailableReservations(request: GetAvailableSlotsRequest) async throws {
        let availableReserationsDTO: AvailableSlotsResponseDTO = try await networkService.fetch(
            from: GetAvailableSlotsEndpoint(request: request)
        )
        let availableReservations = self.mapper.map(dto: availableReserationsDTO)
        await store.setCurrent(to: availableReservations)
    }
}

extension JSONDecoder {
    static let availableReservationDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
