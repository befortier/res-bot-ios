//
//  GetAvailableSlotsUseCase.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

protocol GetAvailableSlotsUseCase: Sendable {
    func callAsFunction(
        request: GetAvailableSlotsRequest
    ) async throws
}

struct GetAvailableSlotsUseCaseLive: GetAvailableSlotsUseCase {

    let repository: any AvailableReservationsRepository

    func callAsFunction(
        request: GetAvailableSlotsRequest
    ) async throws {
        try await repository.refreshAvailableReservations(request: request)
    }
}
