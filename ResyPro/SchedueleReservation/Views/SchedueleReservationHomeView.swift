//
//  SchedueleReservationHomeView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct SchedueleReservationHomeView: View {
    var body: some View {
        VStack {
            SchedeuledReservationsCarouselView()

            NavigationLink(destination: SchedueleReservationFormView()) {
                Text("Scheduele New Reservation")
            }
        }
    }
}

struct SchedueleReservationFormView: View {
    @EnvironmentObject var supportedRestaurantStore: SupportedRestaurantStoreLive
    @Environment(\.modelContext) var modelContext
    @Environment(\.resyConfig) var resyConfig
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack(spacing: 16) {
            self.header
            Divider()
            self.formContent
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color(UIColor.systemGray6))
    }

    private var header: some View {
        VStack(spacing: 16) {
            if let selectedRestaurant = viewModel.selectedRestaurant {
                SupportedRestaurantDescriptionView(supportedRestaurant: selectedRestaurant)


                if viewModel.confirmedReservationDate {
                    Text("Reservation time: ") + Text(viewModel.reservationDate, formatter: DateIntervalFormatter.short)


                    if viewModel.confirmedQueuedDate {
                        Text("Bot time: ") + Text(viewModel.queuedDate, formatter: DateFormatter.short)


                        if let partySize = viewModel.partySize {
                            Button("All Set!") {

                                
                                let schedueledReservation = SchedueledReservation(
                                    id: UUID().uuidString,
                                    restaurant: selectedRestaurant,
                                    createdAt: .now,
                                    acceptedDateInterval: viewModel.reservationDate,
                                    bookDate: viewModel.queuedDate,
                                    partySize: partySize,
                                    scheduelingBehavior: .slowAndSmooth
                                )

                                modelContext.insert(schedueledReservation)
                            }
                        }
                    }
                }
            }

        }
    }

    private var formContent: some View {
        VStack(spacing: 16) {
            if viewModel.selectedRestaurant == nil {
                self.supportedRestaurantsView
            } else if !viewModel.confirmedReservationDate {
                self.reservationDateView
            }  else if !viewModel.confirmedQueuedDate {
                self.queuedDateView
            } else {
                TextField("Party Size", text: $viewModel.partySizeString)
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.partySizeString) { _, newValue in
                        viewModel.partySize = Int(newValue)
                    }
            }
        }
    }

    private var supportedRestaurantsView: some View {
        SupportedRestaurantsView(
            viewModel: .init(supportedRestaurantStore: supportedRestaurantStore)
        ) { supportedRestaurant in
            SupportedRestaurantsCard(supportedRestaurant: supportedRestaurant)
                .onTapGesture {
                    viewModel.selectedRestaurant = supportedRestaurant
                }
        }
    }

    @ViewBuilder
    private var reservationDateView: some View {
        Text("What times would you like to eat?")
            .font(.callout)
            .foregroundColor(.primary)

        SelectDateRangeView(selectedDateRange: $viewModel.reservationDate)
            .datePickerStyle(.compact)

        if viewModel.reservationDate.end > .now {
            Button("Confirm") {
                viewModel.confirmedReservationDate = true
            }
        }
    }

    @ViewBuilder
    private var queuedDateView: some View {
        SelectDateView(
            title: "When does the reservation appear?",
            selectedDate: $viewModel.queuedDate
        )
        .setSelectDateViewStyleKey(to: .vertical)

        if viewModel.queuedDate > .now {
            Button("Confirm") {
                viewModel.confirmedQueuedDate = true
            }
        }
    }


}
extension SchedueleReservationFormView {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published var selectedRestaurant: SupportedRestaurant?

        @Published var reservationDate: DateInterval = .init(start: .now, end: .now)
        @Published var confirmedReservationDate = false


        @Published var queuedDate: Date = .now
        @Published var confirmedQueuedDate = false

        @Published var partySizeString: String = ""
        @Published var partySize: Int?


    }
}

