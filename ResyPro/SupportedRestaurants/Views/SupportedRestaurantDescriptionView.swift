//
//  SupportedRestaurantDescriptionView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct SupportedRestaurantDescriptionView: View {
    let supportedRestaurant: SupportedRestaurant

    var body: some View {
        VStack(spacing: 8) {
            Text(supportedRestaurant.name)
                .font(.title)

            if let reservation = supportedRestaurant.reservation {
                Text(reservation)
                    .font(.subheadline)
            }
        }
    }
}
