//
//  AvailableReservationsView+ViewModel.swift
//  ResyPro
//
//  Created by OpenAI on 6/25/24.
//

import Foundation
import Venues

extension AvailableReservationsView {
struct ViewState: Equatable {
enum Step: Equatable, Sendable {
case selectTime
case selectVenues
}

var step: Step = .selectTime
var dateInterval: DateInterval
var partySizeRange: ClosedRange<Int>
var selectedVenueIDs: Set<Int>
}

@MainActor
final class ViewModel: ObservableObject {
@Published var state: ViewState
let allVenues: [Venue]
private let repository: any AvailableReservationsRepository

init(allVenues: [Venue], repository: any AvailableReservationsRepository) {
self.allVenues = allVenues
self.repository = repository
let calendar = Calendar.current
let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date()) ?? .now
let start = calendar.date(bySettingHour: 18, minute: 30, second: 0, of: tomorrow) ?? tomorrow
let end = calendar.date(bySettingHour: 21, minute: 0, second: 0, of: tomorrow) ?? start.addingTimeInterval(60 * 60 * 2.5)
self.state = ViewState(
dateInterval: DateInterval(start: start, end: end),
partySizeRange: 2...4,
selectedVenueIDs: Set(allVenues.map(\.venueID))
)
}

func submit() async {
let request = CheckAvailableReservationsRequest(
interval: state.dateInterval,
partySizeRange: state.partySizeRange,
venueIDs: Array(state.selectedVenueIDs)
)
_ = try? await repository.checkAvailableReservations(request: request)
}
}
}
