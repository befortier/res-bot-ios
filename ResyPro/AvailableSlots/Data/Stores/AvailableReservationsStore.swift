//
//  AvailableReservationsStore.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

@MainActor
protocol AvailableReservationsStore: Sendable {
    func setCurrent(to availableReservations: [AvailableReservation]?)
}

@MainActor
final class AvailableReservationsStoreLive: AvailableReservationsStore, ObservableObject {
    let restaurantName: String
    @Published private(set) var current: [AvailableReservation]?

    init(restaurantName: String) {
        self.restaurantName = restaurantName
    }

    func setCurrent(to availableReservations: [AvailableReservation]?) {
        self.current = current
    }
}
