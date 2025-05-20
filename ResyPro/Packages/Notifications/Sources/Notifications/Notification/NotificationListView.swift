import DesignSystem
import ProjectFoundation
import SwiftUI
import Venues

/// Displays a user's existing notifications.
public struct NotificationListView: View {
	@State private var state: RemoteViewState<[VenueNotification]> = .loading
	@State private var expanded: Set<Int> = []
	@State private var showDeleteError = false
	private let repository: any NotificationRepository
	private let venuesByID: [Int: Venue]
	
	/// Creates the list view using a repository and known venues.
	/// - Parameters:
	///   - venues: Lookup of venues associated with notifications.
	///   - repository: Data source for notifications.
	public init(
	    venues: [Venue],
	    repository: any NotificationRepository
	) {
	    self.venuesByID = Dictionary(uniqueKeysWithValues: venues.map { ($0.venueID, $0) })
	    self.repository = repository
	}
	
	public var body: some View {
	    ScrollView {
	        VStack(spacing: 12) {
	            switch state {
	            case .loading:
	                DefaultProgressView()
	            case .failed(let error):
	                ErrorView(error: error)
	            case .success(let venueNotifications):
	                ForEach(venueNotifications) { venueNotification in
	                    DisclosureGroup(
	                        isExpanded: Binding(
	                            get: { expanded.contains(venueNotification.id) },
	                            set: { isExpanded in
	                                if isExpanded { expanded.insert(venueNotification.id) }
	                                else { expanded.remove(venueNotification.id) }
	                            }
	                        )
	                    ) {
	                        ForEach(venueNotification.notifications, id: \.self) { ticket in
	                            NotificationCard(
	                                request: ticket,
	                                venue: venuesByID[venueNotification.venueID],
	                                onDelete: {
	                                    Task {
	                                        let req = DeleteNotificationRequest(
	                                            venueID: ticket.venueID,
	                                            startTime: ticket.interval.start,
	                                            partySize: ticket.partySize
	                                        )
	                                        do {
	                                            try await repository.delete(req)
	                                            await MainActor.run {
	                                                withAnimation {
	                                                    remove(ticket: ticket, from: venueNotification.venueID)
	                                                }
	                                            }
	                                        } catch {
	                                            await MainActor.run { showDeleteError = true }
	                                        }
	                                    }
	                                }
	                            )
	                        }
	                    } label: {
	                        HStack {
	                            HorizontalVenueCard(
	                                model: HorizontalVenueCardModel(venue: venuesByID[venueNotification.venueID]!)
	                            )
	                            Spacer()
	                            Button {
	                                Task {
	                                    let requests = venueNotification.notifications.map {
	                                        DeleteNotificationRequest(
	                                            venueID: $0.venueID,
	                                            startTime: $0.interval.start,
	                                            partySize: $0.partySize
	                                        )
	                                    }
	                                    do {
	                                        try await repository.delete(requests)
	                                        await MainActor.run {
	                                            withAnimation {
	                                                remove(venueID: venueNotification.venueID)
	                                            }
	                                        }
	                                    } catch {
	                                        await MainActor.run { showDeleteError = true }
	                                    }
	                                }
	                            } label: {
	                                Image(systemName: "trash")
	                                    .foregroundColor(.error)
	                            }
	                            .buttonStyle(.borderless)
	                        }
	                    }
	                }
	            }
	        }
	        .padding()
	    }
	    .task { await load() }
	    .sheet(isPresented: $showDeleteError) {
	        ErrorView(error: DeleteFailure())
	    }
	}

	private func load() async {
	    do {
	        let notes = try await repository.getAllNotifications()
	        state = .success(notes)
	    } catch {
	        state = .failed(error)
	    }
	}

    func remove(ticket: NotificationTicket, from venueID: Int) {
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

    func remove(venueID: Int) {
	    guard case .success(var notes) = state else { return }
	    notes.removeAll { $0.venueID == venueID }
	    expanded.remove(venueID)
	    state = .success(notes)
	}

    struct DeleteFailure: LocalizedError {
	    var errorDescription: String? {
	        "Failed to delete. Please try again later."
	    }
	}
}
