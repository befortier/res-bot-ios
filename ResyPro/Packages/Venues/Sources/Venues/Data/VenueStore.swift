import Foundation
import SwiftData
import ProjectFoundation

/// Stores and retrieves ``Venue`` objects from persistent storage.
@MainActor
public protocol VenueStore: Sendable {
	/// Saves the venue if it does not already exist in storage.
	func saveIfNeeded(_ venue: Venue) throws
	/// Returns the venue with the given identifier if present.
	func venue(withID id: Int) throws -> Venue?
}

/// Default implementation of ``VenueStore`` using ``ModelContainer``.
public struct VenueStoreLive: VenueStore {
	private let container: any ModelContainerProtocol

	public init(container: any ModelContainerProtocol) {
	self.container = container
}

	public func saveIfNeeded(_ venue: Venue) throws {
	let context = container.mainContext
	let predicate = #Predicate<Venue> { $0.venueID == venue.venueID }
	let descriptor = FetchDescriptor(predicate: predicate)
	if try context.fetch(descriptor).first == nil {
	context.insert(venue)
	try context.save()
	}
	}

	public func venue(withID id: Int) throws -> Venue? {
	let context = container.mainContext
	let predicate = #Predicate<Venue> { $0.venueID == id }
	let descriptor = FetchDescriptor(predicate: predicate)
	return try context.fetch(descriptor).first
}
}
