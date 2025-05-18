//
//  AvailableReservationsStore.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import ProjectFoundation

typealias AvailableReservationsStore = DataStore<[AvailableReservation]>
typealias AvailableReservationsStoreLive = InMemoryDataStore<[AvailableReservation]>
