//
//  ManualSchedueleBookingView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/27/24.
//

import Foundation
import SwiftUI
import DesignSystem

struct ManualSchedueleBookingView: View {
    @State private var firstDateConfirmed = false

    @Binding var reservationDate: DateInterval
    @Binding var queuedDate: Date
    var confirmed: () -> Void

    var body: some View {
        if !firstDateConfirmed {
            self.reservationDateView
        } else {
            Text("Reservation time: ") + Text(reservationDate, formatter: DateIntervalFormatter.short)

            self.queuedDateView
        }
    }

    @ViewBuilder
    private var reservationDateView: some View {
        VStack(spacing: 20) {
            Text("What times would you like to eat?")
                .font(.callout)
                .foregroundColor(.textPrimary)

            SelectDateRangeView(selectedDateRange: $reservationDate)
                .datePickerStyle(.compact)

            Button("Confirm") {
                self.firstDateConfirmed = true
            }
            .buttonStyle(PrimaryButtonStyle())
        }
    }

    @ViewBuilder
    private var queuedDateView: some View {
        SelectDateView(
            title: "When does the reservation appear?",
            selectedDate: $queuedDate
        )
        .setSelectDateViewStyleKey(to: .vertical)

        Button("Confirm") {
            self.confirmed()
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}
