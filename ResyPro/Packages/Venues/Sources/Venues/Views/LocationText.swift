//
//  LocationText.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//


import Foundation
import SwiftUI

/// A struct defined in the Venues module.
struct LocationText: View {
    let location: Location

    var body: some View {
        HStack(spacing: 4) {
            Text(location.neighborhood)
            Text("·")
            Text(location.name)
        }
    }
}
