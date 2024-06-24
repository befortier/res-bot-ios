//
//  LocationText.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/24/24.
//

import Foundation
import SwiftUI

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
