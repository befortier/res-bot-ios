//
//  VenueDescriptionLabel.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

extension Text {
    init(cuisineType: String, priceRange: Int) {
        self.init("\(cuisineType) · \(Array(repeating: "$", count: priceRange).joined())")
    }

    init(neighborhood: String, city: String) {
        self.init("\(neighborhood) · \(city)")
    }
}
