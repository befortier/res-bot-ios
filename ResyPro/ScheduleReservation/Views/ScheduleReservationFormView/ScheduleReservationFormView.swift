//
//  ScheduleReservationFormView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/22/24.
//

import Foundation
import SwiftUI
import SwiftData
import DesignSystem
import Venues
import ProjectFoundation

struct ScheduleReservationFormView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.projectModelContainer) private var modelContainer: any ModelContainerProtocol
    @StateObject var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        VStack(spacing: 16) {
            self.venueDescriptionView
            self.header
            Divider()
            self.formContent
            Spacer()
        }
    }

    @ViewBuilder
    private var header: some View {
        VStack(spacing: 16) {
            switch viewModel.state {
            case .selectDates:
                EmptyView()
            case .selectPartySize(let reservationDate, let queuedDate):
                Text("Reservation time: ") + Text(reservationDate, formatter: DateIntervalFormatter.short)
                Text("Bot time: ") + Text(queuedDate, formatter: DateFormatter.short)

            case .selectSeatingOptions(let reservationDate, let queuedDate, let partySize):
                Text("Reservation time: ") + Text(reservationDate, formatter: DateIntervalFormatter.short)
                Text("Bot time: ") + Text(queuedDate, formatter: DateFormatter.short)
                Text("Party Size: \(partySize)")
            case .finished(let finishedState):
                Text("Reservation time: ") + Text(finishedState.acceptedDateInterval, formatter: DateIntervalFormatter.short)
                Text("Bot time: ") + Text(finishedState.bookingDate, formatter: DateFormatter.short)
                Button("Confirm") {
                    Task {
                        try await viewModel.scheduleReservation(
                            modelContainer: modelContainer,
                            finishedState: finishedState
                        )
                    }
                }
            }
        }
    }

    private var formContent: some View {
        VStack(spacing: 16) {
            switch viewModel.state {
            case .selectDates(let dateBookingState):
                switch dateBookingState {
                case .manual:
                    ManualScheduleBookingView(
                        reservationDate: $viewModel.reservationDate,
                        queuedDate: $viewModel.queuedDate,
                        confirmed: dateWasConfirmed
                    )
                case .automatic(let bookingInfoDTO):
                    AutomaticScheduleBookingView(
                        viewModel: AutomaticScheduleBookingView.ViewModel(
                            reservationDate: $viewModel.reservationDate,
                            queuedDate: $viewModel.queuedDate,
                            bookingInfo: bookingInfoDTO
                        ),
                        confirmed: dateWasConfirmed
                    )
                }
            case .selectPartySize(let acceptedDateInterval, let bookingDate):
                IconTextField(
                    icon: "person",
                    placeholder: "Party Size",
                    text: $viewModel.partySizeString
                )
                .keyboardType(.numberPad)
                .onChange(of: viewModel.partySizeString) { _, newValue in
                    guard let partySize = Int(newValue) else { return }
                    viewModel.state = .selectSeatingOptions(acceptedDateInterval, bookingDate, partySize)
                }
                .padding(.horizontal, 54)

            case .selectSeatingOptions(let acceptedDateInterval, let bookingDate, let partySize):
                SeatingOptionSelectionView(
                    selectedOptions: $viewModel.seatingOptions,
                    knownOptions: viewModel.knownSeatingOptions
                )

                Button("Confirm") {
                    viewModel.state = .finished(
                        FinishedState(
                            acceptedDateInterval: acceptedDateInterval,
                            bookingDate: bookingDate,
                            partySize: partySize,
                            seatingOptions: viewModel.seatingOptions
                        )
                    )
                }
            case .finished:
                // Probably want some loading state
                Text("Success!")
            }
        }
    }

    private var venueDescriptionView: some View {
        VStack(spacing: 8) {
            Text(viewModel.venue.name)
                .font(.design(.title))

            if let needToKnow = viewModel.venue.needToKnow {
                Text(needToKnow)
                    .font(.design(.subheadline))
            }
        }
    }

    @ViewBuilder
    private func reservationDateView(dateSelected: @escaping (DateInterval) -> Void) -> some View {
        VStack(spacing: 20) {
            Text("What times would you like to eat?")
                .font(.design(.callout))
                .foregroundColor(.textPrimary)

            SelectDateRangeView(selectedDateRange: $viewModel.reservationDate)
                .datePickerStyle(.compact)

            Button("Confirm") {
                dateSelected(viewModel.reservationDate)
            }
            .buttonStyle(PrimaryButtonStyle())
        }
    }

    @ViewBuilder
    private func queuedDateView(dateSelected: @escaping (Date) -> Void) -> some View {
        SelectDateView(
            title: "When does the reservation appear?",
            selectedDate: $viewModel.queuedDate
        )
        .setSelectDateViewStyleKey(to: .vertical)
        .padding(.bottom, 24)
        .padding(.leading, 8)

        Button("Confirm") {
            dateSelected(viewModel.queuedDate)
        }
        .buttonStyle(PrimaryButtonStyle())
    }

    private func dateWasConfirmed() {
        self.viewModel.state = .selectPartySize(
            self.viewModel.reservationDate,
            self.viewModel.queuedDate
        )
    }
}
