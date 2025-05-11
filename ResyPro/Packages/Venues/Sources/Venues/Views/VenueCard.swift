//
//  VenueCard.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import SwiftUI
import NukeUI
import DesignSystem

/// A horizontally styled card for displaying a venue.
public struct VenueCard: View {

    // MARK: - Properties

    private let imageAspectRatio: CGFloat = 1.0

    private let imageURL: URL?
    private let name: String
    private let cuisineType: String
    private let priceRange: Int
    private let location: Location

    // MARK: - Init

    public init(venue: Venue) {
        self.init(
            imageURL: venue.images.first,
            name: venue.name,
            cuisineType: venue.cuisineType,
            priceRange: venue.priceRange,
            location: venue.location
        )
    }

    public init(
        imageURL: URL?,
        name: String,
        cuisineType: String,
        priceRange: Int,
        location: Location
    ) {
        self.imageURL = imageURL
        self.name = name
        self.cuisineType = cuisineType
        self.priceRange = priceRange
        self.location = location
    }

    // MARK: - Body

    public var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 12) {
                venueImage
                    .frame(width: geometry.size.width/3)
                    .clipped()

                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.headline)
                        .foregroundStyle(Color.textPrimary)

                    LocationText(location: location)
                        .font(.subheadline)
                        .foregroundStyle(Color.textSecondary)

                    VenueDescriptionLabel(
                        cuisineType: cuisineType,
                        priceRange: priceRange
                    )
                    .font(.caption)
                    .foregroundStyle(Color.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                }
                .padding(4)
            }
        }
        .aspectRatio(24/9, contentMode: .fill)
        .cardStyle()
    }

    // MARK: - Image

    @MainActor
    private var venueImage: some View {
        LazyImage(url: imageURL) { state in
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
    VenueCard(
        imageURL: URL(string: "https://cdn.vox-cdn.com/thumbor/2lEqOWelF_xNUE_Qi-pXd0k7jUg=/1400x1050/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/24036251/Laser_Wolf_23.jpg")!,
        name: "Laser Wolf",
        cuisineType: "Mediterranian",
        priceRange: 3,
        location: .init(timeZone: "EST", neighborhood: "Chelsea", geo: .init(latitude: 0, longitude: 0), code: "chelsaea", name: "New York", urlSlug: "chelsea")
    )
    .padding()
}
