//
//  SchedueleReservationFormView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/22/24.
//

import Foundation
import SwiftUI
import SwiftData

struct SchedueleReservationFormView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.resyConfig) var resyConfig
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack(spacing: 16) {
            if viewModel.state != .selectVenue {
                self.header
                Divider()
            }

            self.formContent
            Spacer()
        }
        .background(Color(UIColor.systemGray6))
        .ignoresSafeArea(edges: viewModel.state == .selectVenue ? [] : .top)
        .navigationBarBackButtonHidden(true) // Hide the default back button
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left") // Custom back button image
                        Text("Back") // Custom back button text
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var header: some View {
        VStack(spacing: 16) {
            switch viewModel.state {
            case .selectVenue:
                EmptyView()

            case .selectReservationDate(let venue):
                self.venueDescriptionView(venue: venue)
                // can I use falltrhgouh?

            case .selectBookingDate(let venue, let reservationDate):
                self.venueDescriptionView(venue: venue)
                Text("Reservation time: ") + Text(reservationDate, formatter: DateIntervalFormatter.short)

            case .selectPartySize(let venue, let reservationDate, let queuedDate):
                self.venueDescriptionView(venue: venue)
                Text("Reservation time: ") + Text(reservationDate, formatter: DateIntervalFormatter.short)
                Text("Bot time: ") + Text(queuedDate, formatter: DateFormatter.short)

            case .finished(let finishedState):
                self.venueDescriptionView(venue: finishedState.venue)
                Text("Reservation time: ") + Text(finishedState.acceptedDateInterval, formatter: DateIntervalFormatter.short)
                Text("Bot time: ") + Text(finishedState.bookingDate, formatter: DateFormatter.short)
                Button("All Set!") {
                    Task {
                        try await viewModel.schedueleReservation(
                            modelContext: modelContext, finishedState: finishedState
                        )
                    }
                }

            }
        }
    }

    private var formContent: some View {
        VStack(spacing: 16) {
            switch viewModel.state {
            case .selectVenue:
                self.venuesListView
            case .selectReservationDate(let venue):
                self.reservationDateView { reservationDate in
                    self.viewModel.state = .selectBookingDate(venue, reservationDate)
                }
            case .selectBookingDate(let venue, let reservationDate):
                self.queuedDateView { bookingDate in
                    self.viewModel.state = .selectPartySize(venue, reservationDate, bookingDate)
                }
            case .selectPartySize(let venue, let acceptedDateInterval, let bookingDate):
                TextField("Party Size", text: $viewModel.partySizeString)
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.partySizeString) {
                        _,
                        newValue in
                        guard let partySize = Int(newValue) else { return }
                        viewModel.state = .finished(
                            FinishedState(
                                venue: venue,
                                acceptedDateInterval: acceptedDateInterval,
                                bookingDate: bookingDate,
                                partySize: partySize
                            )
                        )
                    }
            case .finished(let finishedState):
                // Probably want some loading state
                Text("Success!")
            }
        }
    }

    private func venueDescriptionView(venue: Venue) -> some View {
        VenueDescriptionView(
            name: venue.name,
            needToKnow: venue.needToKnow,
            imageURLS: venue.images
        )
        .frame(maxHeight: 300)
    }

    private var venuesListView: some View {
        VenuesListView(
            viewModel: .init(modelContext: self.modelContext)
        ) { venue in
            VenueCard(venue: venue)
                .onTapGesture {
                    viewModel.state = .selectReservationDate(venue)
                }
                .padding(.horizontal, 16)
        }
    }

    @ViewBuilder
    private func reservationDateView(dateSelected: @escaping (DateInterval) -> Void) -> some View {
        Text("What times would you like to eat?")
            .font(.callout)
            .foregroundColor(.primary)

        SelectDateRangeView(selectedDateRange: $viewModel.reservationDate)
            .datePickerStyle(.compact)


        Button("Confirm") {
            dateSelected(viewModel.reservationDate)
        }
        .buttonStyle(PrimaryButtonStyle())
    }

    @ViewBuilder
    private func queuedDateView(dateSelected: @escaping (Date) -> Void) -> some View {
        SelectDateView(
            title: "When does the reservation appear?",
            selectedDate: $viewModel.queuedDate
        )
        .setSelectDateViewStyleKey(to: .vertical)

        Button("Confirm") {
            dateSelected(viewModel.queuedDate)
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}
