import Foundation
import SwiftUI

/// Coordinates data and actions for ``NotificationListView``.
@MainActor
public final class NotificationListViewModel: ObservableObject {
	/// Current loading state of notifications.
	@Published public private(set) var state: RemoteViewState<[VenueNotification]> = .loading
	/// Expanded venue identifiers.
	@Published public var expanded: Set<Int> = []
	/// Controls display of a delete error alert.
	@Published public var showDeleteError = false

	private let repository: any NotificationRepository

	/// Creates a new view model.
	/// - Parameter repository: Source for notification data.
	public init(repository: any NotificationRepository) {
		self.repository = repository
	}

	/// Loads notifications from the repository.
	public func load() async {
		do {
			let notes = try await repository.getAllNotifications()
			state = .success(notes)
		} catch {
			state = .failed(error)
		}
	}

	/// Removes a ticket from the stored state.
	/// - Parameters:
	///   - ticket: Ticket to remove.
	///   - venueID: Identifier of the parent venue.
	public func remove(ticket: NotificationTicket, from venueID: Int) {
		guard case .success(var notes) = state else { return }
		if let index = notes.firstIndex(where: { $0.venueID == venueID }) {
			var venueNote = notes[index]
			venueNote.notifications.removeAll { $0 == ticket }
			if venueNote.notifications.isEmpty {
				notes.remove(at: index)
				expanded.remove(venueID)
			} else {
				notes[index] = venueNote
			}
			state = .success(notes)
		}
	}

	/// Removes an entire venue and associated tickets.
	/// - Parameter venueID: Venue identifier to remove.
	public func remove(venueID: Int) {
		guard case .success(var notes) = state else { return }
		notes.removeAll { $0.venueID == venueID }
		expanded.remove(venueID)
		state = .success(notes)
	}

	/// Attempts to delete the provided ticket from the backend and local state.
	/// - Parameters:
	///   - ticket: Ticket to delete.
	///   - venueID: Parent venue identifier.
	public func delete(ticket: NotificationTicket, from venueID: Int) async {
		let req = DeleteNotificationRequest(
			venueID: ticket.venueID,
			startTime: ticket.interval.start,
			partySize: ticket.partySize
		)
		do {
			try await repository.delete(req)
			withAnimation { remove(ticket: ticket, from: venueID) }
		} catch {
			showDeleteError = true
		}
	}

	/// Attempts to delete all tickets for the provided venue from the backend and local state.
	/// - Parameter venueNotification: Group of tickets to delete.
	public func delete(_ venueNotification: VenueNotification) async {
		let requests = venueNotification.notifications.map {
			DeleteNotificationRequest(
				venueID: $0.venueID,
				startTime: $0.interval.start,
				partySize: $0.partySize
			)
		}
		do {
			try await repository.delete(requests)
			withAnimation { remove(venueID: venueNotification.venueID) }
		} catch {
			showDeleteError = true
		}
	}
}
