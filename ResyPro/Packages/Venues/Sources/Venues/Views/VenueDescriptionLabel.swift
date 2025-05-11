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
        HStack(spacing: 4) {
            self.descriptionView
            self.dotTextView
            self.priceView
        }
    }

    private var descriptionView: some View {
        Text(cuisineType)
    }

    private var priceView: some View {
        Text(
            Array(
                repeating: "$",
                count: self.priceRange
            ).joined()
        )
    }

    private var dotTextView: some View {
        Text("·")
    }
}
