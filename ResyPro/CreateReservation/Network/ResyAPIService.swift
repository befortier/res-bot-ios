//
//  ResyAPIService.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import Network
#if DEBUG
import DebugTools
#endif

struct ResyAPIService: Sendable {

    private let networkService: any NetworkService

    init(networkService: any NetworkService){
        self.networkService = networkService
    }

    func getBookingToken(
        date: String,
        partySize: String,
        slotID: ResySlotID
    ) async throws -> ResyBookingToken {
        let endpoint = GetBookingTokenEndpoint(
            date: date,
            partySize: partySize,
            slotID: "\(slotID)"
        )

        return try await networkService.fetch(from: endpoint)
    }
}
