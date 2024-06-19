//
//  AvailableReservationsRepository.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

protocol AvailableReservationsRepository: Sendable {
    func refreshAvailableReservations(request: GetAvailableSlotsRequest) async throws
}

struct AvailableReservationsRepositoryLive: AvailableReservationsRepository {

    private let networkService: any NetworkService
    private let store: any AvailableReservationsStore
    private let mapper = AvailableReservationResponseMapper()

    init(
        networkService: any NetworkService = NetworkServiceLive(
            client: URLSessionClient(
                session: .shared,
                decoder: .availableReservationDecoder
            )
        ),
        store: any AvailableReservationsStore
    ) {
        self.networkService = networkService
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

struct AvailableReservationResponseMapper: Sendable {
    func map(dto: AvailableSlotsResponseDTO) -> [AvailableReservation] {
        let venues = dto.results.venues
        return venues.flatMap { venueDTO in
            venueDTO.slots.map { slotDTO in
                AvailableReservation(
                    slotID: slotDTO.config.token,
                    time: slotDTO.date.start,
                    bookingAvailabilityStatus: slotDTO.availability.id
                )
            }
        }
    }
}
