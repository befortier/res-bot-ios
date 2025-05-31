import Foundation
import SwiftUI
import ProjectFoundation

/// Coordinates data and actions for ``NotificationListView``.
@MainActor
public final class NotificationListViewModel: ObservableObject {
    /// Current filter being applied.
    public enum Filter: Int, CaseIterable, Sendable {
        case venue
        case date
    }

    /// Current filter selection.
    @Published public var filter: Filter = .date

    /// Notifications grouped by venue.
    @Published public private(set) var venueState: RemoteViewState<[VenueNotification]> = .loading

    /// Notifications grouped by date.
    @Published public private(set) var dateState: RemoteViewState<[DateNotification]> = .loading
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

    /// Loads notifications from the repository using the selected filter.
    ///
    /// Results are cached for the lifetime of this view model so repeated calls
    /// while the view is active will not trigger additional network requests.
    public func load() async {
        switch filter {
        case .venue:
            if case .success = venueState { return }
            await loadByVenue()
        case .date:
            if case .success = dateState { return }
            await loadByDate()
        }
    }

    private func loadByVenue() async {
        do {
            let notes = try await repository.getNotificationsByVenue()
            venueState = .success(notes)
        } catch {
            venueState = .failed(error)
        }
    }

    private func loadByDate() async {
        do {
            let notes = try await repository.getNotificationsByDate()
            dateState = .success(notes)
        } catch {
            dateState = .failed(error)
        }
    }

    /// Removes a ticket from the stored state.
    /// - Parameters:
    ///   - ticket: Ticket to remove.
    ///   - venueID: Identifier of the parent venue.
    public func remove(ticket: NotificationTicket, from venueID: Int) {
        guard case .success(let notes) = venueState else { return }

        let updatedNotes = notes.compactMap { venueNote -> VenueNotification? in
            guard venueNote.venueID == venueID else { return venueNote }
            let remaining = venueNote.notifications.filter { $0 != ticket }
            guard !remaining.isEmpty else {
                expanded.remove(venueID)
                return nil // remove this venueNote entirely
            }
            return VenueNotification(venueID: venueID, notifications: remaining)
        }

        venueState = .success(updatedNotes)
    }

    /// Removes an entire venue and associated tickets.
    /// - Parameter venueID: Venue identifier to remove.
    public func remove(venueID: Int) {
        guard case .success(var notes) = venueState else { return }
        notes.removeAll { $0.venueID == venueID }
        expanded.remove(venueID)
        venueState = .success(notes)
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
