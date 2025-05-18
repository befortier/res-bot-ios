//
//  CodableClosedRange.swift
//  ProjectFoundation
//
//  Created by Ben Fortier on 5/18/25.
//


import Foundation

@propertyWrapper
public struct CodableClosedRange<T: Comparable & Codable & Hashable & Sendable>: Codable, Hashable, Sendable {
    public var wrappedValue: ClosedRange<T>

    public init(wrappedValue: ClosedRange<T>) {
        self.wrappedValue = wrappedValue
    }

    enum CodingKeys: String, CodingKey {
        case lowerBound
        case upperBound
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let lower = try container.decode(T.self, forKey: .lowerBound)
        let upper = try container.decode(T.self, forKey: .upperBound)
        self.wrappedValue = lower...upper
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(wrappedValue.lowerBound, forKey: .lowerBound)
        try container.encode(wrappedValue.upperBound, forKey: .upperBound)
    }
}
