//
//  SchedueleReservationFormView+ViewModel.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/22/24.
//

import Foundation
import SwiftData

extension SchedueleReservationFormView {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published var state: State = .selectVenue
        @Published var selectedVenue: Venue?

        @Published var reservationDate: DateInterval = .init(start: .now, end: .now)
        @Published var confirmedReservationDate = false


        @Published var queuedDate: Date = .now
        @Published var confirmedQueuedDate = false

        @Published var partySizeString: String = ""
        @Published var partySize: Int?

        func schedueleReservation(
            modelContext: ModelContext,
            finishedState: FinishedState
        ) async throws {
            // Optimisticall put yes, if network fails global error modal + remove
            let schedueledReservation = SchedueledReservation(
                id: UUID().uuidString,
                venue: finishedState.venue,
                createdAt: .now,
                acceptedDateInterval: finishedState.acceptedDateInterval,
                bookDate: finishedState.bookingDate,
                partySize: finishedState.partySize,
                scheduelingBehavior: .slowAndSmooth
            )

            modelContext.insert(schedueledReservation)
        }
    }
}


extension SchedueleReservationFormView {
    enum State: Sendable, Equatable {
        case selectVenue

        case selectReservationDate(Venue)

        case selectBookingDate(Venue, DateInterval)

        case selectPartySize(Venue, DateInterval, Date)

        case finished(FinishedState)
    }

    struct FinishedState: Sendable, Equatable {
        let venue: Venue
        let acceptedDateInterval: DateInterval
        let bookingDate: Date
        let partySize: Int
    }
}
