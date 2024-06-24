//
//  VenueCard.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import Nuke
import NukeUI

struct VenueCard: View {

    // MARK: - Properties

    let imageURL: URL?
    let name: String
    let cuisineType: String
    let priceRange: Int
    let location: Location

    // MARK: - Initializer

    init(venue: Venue) {
        self.init(
            imageURL: venue.images.first,
            name: venue.name,
            cuisineType: venue.cuisineType,
            priceRange: venue.priceRange,
            location: venue.location
        )
    }

    init(
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

    var body: some View {
        VStack(spacing: 8) {
            self.imageContainer

            Divider()

            self.textContainer
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .cardStyle()
    }

    private var textContainer: some View {
        VStack(spacing: 4) {
            self.nameView

            VenueDescriptionLabel(
                cuisineType: self.cuisineType,
                priceRange: self.priceRange
            )
            .font(.subheadline)
            .foregroundStyle(.textSecondary)

            LocationText(location: self.location)
                .font(.subheadline)
                .foregroundStyle(.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var nameView: some View {
        Text(self.name)
            .font(.title)
            .foregroundStyle(.textPrimary)
    }

    @ViewBuilder @MainActor
    private var imageContainer: some View {
        if let imageURL {
            LazyImage(url: imageURL) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(4/3, contentMode: .fit)
                } else {
                    Color.gray.opacity(0.2)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    VStack {
        VenueCard(
            imageURL: URL(string: "https://cdn.vox-cdn.com/thumbor/2lEqOWelF_xNUE_Qi-pXd0k7jUg=/1400x1050/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/24036251/Laser_Wolf_23.jpg")!,
            name: "Laser Wolf",
            cuisineType: "Mediterranian",
            priceRange: 3,
            location: .init(timeZone: "EST", neighborhood: "Chelsea", geo: .init(latitude: 0, longitude: 0), code: "chelsaea", name: "New York", urlSlug: "chelsea")
        )
        .frame(height: 128)
        .padding()

    }
}
