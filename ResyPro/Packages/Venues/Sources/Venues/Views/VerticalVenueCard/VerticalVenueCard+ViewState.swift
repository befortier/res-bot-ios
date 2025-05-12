//
//  VerticalVenueCard+ViewState.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

public import Foundation

extension VerticalVenueCard {
    public struct ViewState: Equatable, Sendable, Identifiable {
        public let id: Int
        public let imageURL: URL?
        public let name: String
        public let cuisineType: String
        public let priceRange: Int
        public let neighborhood: String

        public init(
            id: Int,
            imageURL: URL?,
            name: String,
            cuisineType: String,
            priceRange: Int,
            neighborhood: String
        ) {
            self.id = id
            self.imageURL = imageURL
            self.name = name
            self.cuisineType = cuisineType
            self.priceRange = priceRange
            self.neighborhood = neighborhood
        }

        public init(venue: Venue) {
            self.init(
                id: venue.venueID,
                imageURL: venue.images.first,
                name: venue.name,
                cuisineType: venue.cuisineType,
                priceRange: venue.priceRange,
                neighborhood: venue.location.neighborhood
            )
        }
    }
}
