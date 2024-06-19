//
//  GetAvailableSlotsUseCase.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

struct GetAvailableSlotsUseCase: Sendable {
    
    let repository: any AvailableReservationsRepository

    func callAsFunction(
        request: GetAvailableSlotsRequest
    ) async throws {
        try await repository.refreshAvailableReservations(request: request)
    }
}
