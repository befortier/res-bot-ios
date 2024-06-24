//
//  VenueDescriptionView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct VenueDescriptionView: View {
    let name: String
    let needToKnow: String?
    let imageURLS: [URL]

    var body: some View {
        VStack(spacing: 8) {
            ImagesCarouselView(imageUrls: imageURLS)

            Text(name)
                .font(.title)

            if let needToKnow = needToKnow {
                Text(needToKnow)
                    .font(.subheadline)
            }
        }
    }
}
