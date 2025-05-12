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
            VStack(spacing: .zero) {
                imageSection
                    .frame(height: geo.size.height * 0.45)
                    .clipped()

                VStack(spacing: 2) {
                    Text(viewState.name)
                        .font(.headline)
                        .foregroundStyle(Color.textPrimary)
                        .padding(.bottom, 4)

                    Text(viewState.cuisineType)
                        .font(.callout)
                        .foregroundStyle(Color.textSecondary)
                        .lineLimit(2)

                    Text(viewState.neighborhood)
                        .font(.footnote)
                        .foregroundStyle(Color.textSecondary)
                }
                .padding(12)
            }
        }
        .overlay(alignment: .bottomLeading) {
            Text(price: viewState.priceRange)
                .font(.caption2)
                .foregroundStyle(Color.textSecondary)
                .padding(4)
        }
        .aspectRatio(0.85, contentMode: .fit)
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

// MARK: Prevew

#Preview {
    VerticalVenueCard(viewState: .init(venue: .laserWolf))
        .frame(height: 200)
}
