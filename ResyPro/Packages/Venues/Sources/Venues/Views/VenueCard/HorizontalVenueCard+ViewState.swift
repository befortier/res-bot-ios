//
//  HorizontalVenueCard+ViewState.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import Foundation

/// Immutable data model for ``HorizontalVenueCard``.
extension HorizontalVenueCard {
public struct ViewState: Sendable, Equatable, Identifiable {
public let id: Int
public let imageURL: URL?
public let name: String
public let cuisineType: String
public let priceRange: Int
public let neighborhood: String
public let locationName: String

public init(
id: Int,
imageURL: URL?,
name: String,
cuisineType: String,
priceRange: Int,
neighborhood: String,
locationName: String
) {
self.id = id
self.imageURL = imageURL
self.name = name
self.cuisineType = cuisineType
self.priceRange = priceRange
self.neighborhood = neighborhood
self.locationName = locationName
}
}
}
