//
//  DataStore.swift
//  ProjectFoundation
//
//  Created by Ben Fortier on 6/19/24.
//


import Foundation
import Combine

@MainActor
/// A protocol defined in the ProjectFoundation module.
public protocol DataStore<T>: Sendable {
    associatedtype T = Sendable & Equatable

    var current: T? { get }
    var publisher: AnyPublisher<T?, Never> { get }

    func setCurrent(to newData: T?)
}

@MainActor
public class DataStoreLive<T>: DataStore, ObservableObject {
    @Published public private(set) var current: T?
    public var publisher: AnyPublisher<T?, Never> { $current.eraseToAnyPublisher() }

    public init(current: T? = nil) {
        self.current = current
    }

    public func setCurrent(to newData: T?) {
        self.current = newData
    }
}
