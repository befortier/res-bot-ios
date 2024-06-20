//
//  SupportedRestaurantsCard.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct SupportedRestaurantsCard: View {
    let supportedRestaurant: SupportedRestaurant

    var body: some View {
        Text(supportedRestaurant.name)
            .font(.title)
            .padding()
            .background(Color.green.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
