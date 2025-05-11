//
//  VenueDescriptionLabel.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

/// A struct defined in the Venues module.
struct VenueDescriptionLabel: View {
    
    let cuisineType: String
    let priceRange: Int

    var body: some View {
        Text("\(cuisineType) · \(Array(repeating: "$", count: self.priceRange).joined())")
    }
}
