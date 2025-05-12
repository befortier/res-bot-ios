//
//  VerticalVenueCard.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI
import NukeUI
import DesignSystem

/// A vertically stacked venue card with circular image and centered content.
public struct VerticalVenueCard: View {
    private let viewState: ViewState

    public init(viewState: ViewState) {
        self.viewState = viewState
    }

    public var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                imageSection
                    .frame(height: geo.size.height * 0.45)
                    .clipped()

                VStack(spacing: 4) {
                    Text(viewState.name)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 4)
                    Text("\(viewState.cuisineType) • \(String(repeating: "$", count: viewState.priceRange))")
                        .font(.subheadline)
                        .foregroundStyle(Color.textSecondary)

                    Text(viewState.neighborhood)
                        .font(.footnote)
                        .foregroundStyle(Color.textSecondary)
                }
                .padding(12)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .cardStyle()
    }

    private var imageSection: some View {
        LazyImage(url: viewState.imageURL) { state in
            if let image = state.image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray.opacity(0.2)
            }
        }
    }
}


#Preview {
    VerticalVenueCard(viewState: .init(venue: .laserWolf))
        .frame(height: 200)
}
