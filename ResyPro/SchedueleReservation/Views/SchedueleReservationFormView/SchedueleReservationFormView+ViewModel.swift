//
//  SchedueleReservationFormView+ViewModel.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/22/24.
//

import Foundation
import SwiftData
import Venues

extension SchedueleReservationFormView {
    @MainActor
    final class ViewModel: ObservableObject {
        let venue: Venue

        var knownSeatingOptions: [String] {
            Array(Set(venue.slots.map { $0.exactSeat })).sorted()
        }
        @Published var state: State

        @Published var reservationDate: DateInterval = .init(start: .now, end: .now)
        @Published var confirmedReservationDate = false

        @Published var queuedDate: Date = .now
        @Published var confirmedQueuedDate = false

        @Published var partySizeString: String = ""
        @Published var partySize: Int?
        @Published var seatingOptions: [String] = []

        init(venue: Venue) {
            self.venue = venue

            self.state = if let bookingInfo = venue.bookingInfo {
                .selectDates(.automatic(.init(daysOut: bookingInfo.daysOut, time: bookingInfo.time)))
            } else {
                .selectDates(.manual)
            }
        }

        func schedueleReservation(
            modelContext: ModelContext,
            finishedState: FinishedState
        ) async throws {
            // Optimisticall put yes, if network fails global error modal + remove
            let schedueledReservation = SchedueledReservation(
                id: UUID().uuidString,
                venue: self.venue,
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
    enum SelectDateState: Sendable, Equatable {
        case manual

        case automatic(BookingInfoDTO)
    }

    enum State: Sendable, Equatable {
        case selectDates(SelectDateState)

        case selectPartySize(DateInterval, Date)

        case selectSeatingOptions(DateInterval, Date, Int)

        case finished(FinishedState)
    }

    struct FinishedState: Sendable, Equatable {
        let acceptedDateInterval: DateInterval
        let bookingDate: Date
        let partySize: Int
        let seatingOptions: [String]
    }
}
