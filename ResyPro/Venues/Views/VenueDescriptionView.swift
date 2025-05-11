//
//  VenueDescriptionView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import DesignSystem

struct VenueDescriptionDTO: Sendable {
    let name: String
    let needToKnow: String?
    let imageURLS: [URL]
}

struct VenueDescriptionView: View {
    let venue: VenueDescriptionDTO
    @State private var totalHeight: CGFloat = .infinity

    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { proxy in
                ImagesCarouselView(imageUrls: venue.imageURLS)
            }
            .frame(maxHeight: totalHeight)
            .background(GeometryReader { geometry in
                Color.clear.preference(
                    key: ViewHeightKey.self,
                    value: [geometry.size.width * 3/4]
                )
            })
            .onPreferenceChange(ViewHeightKey.self) { heights in
                self.totalHeight = heights.reduce(0, +)
            }
            Text(venue.name)
                .font(.title)

            if let needToKnow = venue.needToKnow {
                Text(needToKnow)
                    .font(.subheadline)
            }
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    typealias Value = [CGFloat]

    static var defaultValue: [CGFloat] = []

    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}
