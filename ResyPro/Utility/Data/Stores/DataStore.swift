//
//  DataStore.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import Combine

@MainActor
protocol DataStore<T>: Sendable {
    associatedtype T = Sendable & Equatable

    var current: T? { get }
    var publisher: AnyPublisher<T?, Never> { get }

    func setCurrent(to newData: T?)
}

@MainActor
class DataStoreLive<T>: DataStore, ObservableObject {
    @Published private(set) var current: T?
    var publisher: AnyPublisher<T?, Never> { $current.eraseToAnyPublisher() }

    func setCurrent(to newData: T?) {
        self.current = newData
    }
}
