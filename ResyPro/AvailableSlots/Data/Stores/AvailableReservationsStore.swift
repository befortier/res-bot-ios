//
//  AvailableReservationsStore.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

protocol AvailableReservationsStore: DataStore where T == [AvailableReservation] {
    var restaurantName: String { get }
}

@MainActor
final class AvailableReservationsStoreLive: DataStoreLive<[AvailableReservation]>, AvailableReservationsStore {
    typealias T = [AvailableReservation]

    let restaurantName: String

    init(restaurantName: String) {
        self.restaurantName = restaurantName
    }
}
