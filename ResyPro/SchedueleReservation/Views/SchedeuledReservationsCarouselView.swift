//
//  SchedeuledReservationsCarouselView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import SwiftData

struct SchedeuledReservationsCarouselView: View {
    @Query private var schedueledReservations: [SchedueledReservation]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(schedueledReservations) { schedueledReservation in
                    SchedeuledReservationsCarouselCard(schedueledReservation: schedueledReservation)
                }
            }
        }
    }
}

struct SchedeuledReservationsCarouselCard: View {
    let schedueledReservation: SchedueledReservation

    var body: some View {
        VStack(spacing: 4) {
            Text(schedueledReservation.venue.name)
                .font(.headline)
                .foregroundStyle(.primary)

            Text(schedueledReservation.acceptedDateInterval, formatter: DateIntervalFormatter.short)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
