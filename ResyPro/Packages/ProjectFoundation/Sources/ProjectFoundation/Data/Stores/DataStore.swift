//
//  DataStore.swift
//  ProjectFoundation
//
//  Created by Ben Fortier on 6/19/24.
//


import Foundation
@preconcurrency import Combine

/// A protocol defined in the ProjectFoundation module.
public protocol DataStore<T>: Sendable {
    associatedtype T = Sendable & Equatable

    var current: T { get async }
    var publisher: AnyPublisher<T, Never> { get async }

    func setCurrent(to newData: T) async
}

@MainActor
public final class InMemoryDataStore<T: Sendable & Equatable>: DataStore {
    @Published public private(set) var currentPublished: T
    public var publisher: AnyPublisher<T, Never> { $currentPublished.eraseToAnyPublisher() }
    public var current: T { currentPublished }

    public init(current: T) {
        self.currentPublished = current
    }

    public nonisolated func setCurrent(to newData: T) async {
        await MainActor.run { self.currentPublished = newData }
    }
}
