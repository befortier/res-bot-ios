import Foundation

/// Maps ``Venue`` values into card view states.
public struct VenueCardViewStateMapper: Sendable {
	public init() {}

	/// Converts a ``Venue`` into a ``HorizontalVenueCard.ViewState``.
	/// - Parameter venue: The source venue.
	public func horizontal(venue: Venue) -> HorizontalVenueCard.ViewState {
		HorizontalVenueCard.ViewState(
			id: venue.venueID,
			imageURL: venue.images.first,
			name: venue.name,
			cuisineType: venue.cuisineType,
			priceRange: venue.priceRange,
			neighborhood: venue.location.neighborhood,
			locationName: venue.location.name
		)
	}

	/// Converts a ``Venue`` into a ``VerticalVenueCard.ViewState``.
	/// - Parameter venue: The source venue.
	public func vertical(venue: Venue) -> VerticalVenueCard.ViewState {
		VerticalVenueCard.ViewState(
			id: venue.venueID,
			imageURL: venue.images.first,
			name: venue.name,
			cuisineType: venue.cuisineType,
			priceRange: venue.priceRange,
			neighborhood: venue.location.neighborhood
		)
	}
}
