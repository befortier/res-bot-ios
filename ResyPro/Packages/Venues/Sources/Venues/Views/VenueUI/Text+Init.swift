//
//  VenueDescriptionLabel.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

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
}
