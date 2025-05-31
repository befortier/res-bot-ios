//
//  VenueDescriptionLabel.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import DesignSystem

extension Text {
    public init(cuisineType: String, priceRange: Int) {
        self.init("\(cuisineType) · \(String(repeating: "$", count: priceRange))")
    }

    public init(neighborhood: String, city: String) {
        self.init("\(neighborhood) · \(city)")
    }

    public init(price: Int) {
        self.init(String(repeating: "$", count: price))
    }

    public init(partySize: Int) {
        self = Text("\(partySize) ") + Text(Image(systemName: "person"))
    }

    public init(partySizes: [Int]) {
        self = Text("\(partySizes.sorted().map { "\($0)"}.joined(separator: ", ")) ") + Text(Image(systemName: "person"))
    }
}

extension Array where Element == Text {
    func joined(separator: Text) -> Text {
        guard let first = first else { return Text("") }
        return dropFirst().reduce(first) { result, next in
            result + separator + next
        }
    }
}
