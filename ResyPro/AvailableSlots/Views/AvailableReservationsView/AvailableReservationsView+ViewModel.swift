//
//  AvailableReservationsView+ViewModel.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import Combine
import ProjectFoundation
import Network

extension AvailableReservationsView {
    @MainActor
    final class ViewModel: ObservableObject {
        typealias ListViewState = RemoteViewState<[AvailableReservation]>

        @Published var selectedDate: Date = .now
        @Published var listState: ListViewState = .loading

        private let store: any AvailableReservationsStore
        private let refreshAvailableSlots: any GetAvailableSlotsUseCase

        private var selectedDateChangedSubscription: AnyCancellable?

        init() {
            let store = AvailableReservationsStoreLive()
            self.store = store
            let repository = AvailableReservationsRepositoryLive(
                configuration: .init(userID: "", bearerToken: "", resyAuthToken: ""),
                store: store
            )
            self.refreshAvailableSlots = GetAvailableSlotsUseCaseLive(repository: repository)

            self.observeForDataChanges()
        }

        private func observeForDataChanges() {
            self.selectedDateChangedSubscription = $selectedDate
                .removeDuplicates()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] newDate in
                    self?.refreshSlots(newDate: newDate)
                }

            self.store
                .publisher
                .map { items -> ListViewState in
                    if let items {
                        .success(items)
                    } else {
                        .loading
                    }
                }
                .receive(on: DispatchQueue.main)
                .assign(to: &$listState)

        }

        private func refreshSlots(
            newDate: Date
        ) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: selectedDate)

            let request = GetAvailableSlotsRequest(
                date: dateString,
                partySize: "2",
                venueID: "2790"
            )

            Task {
                do {
                    try await self.refreshAvailableSlots(request: request)
                } catch {
                    self.listState = .failed(error)
                }
            }
        }
    }
}
