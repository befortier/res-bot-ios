import DesignSystem
import ProjectFoundation
import SwiftUI
import Venues

/// Displays a user's existing notifications.
public struct NotificationListView: View {
        @StateObject private var viewModel: NotificationListViewModel
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
            _viewModel = StateObject(wrappedValue: NotificationListViewModel(repository: repository))
        }
	
        public var body: some View {
            ScrollView {
                VStack(spacing: 12) {
                    switch viewModel.state {
                    case .loading:
                        DefaultProgressView()
                    case .failed(let error):
                        ErrorView(error: error)
                    case .success(let venueNotifications):
                        ForEach(venueNotifications) { venueNotification in
                            DisclosureGroup(
                                isExpanded: Binding(
                                    get: { viewModel.expanded.contains(venueNotification.id) },
                                    set: { isExpanded in
                                        if isExpanded { viewModel.expanded.insert(venueNotification.id) }
                                        else { viewModel.expanded.remove(venueNotification.id) }
                                    }
                                )
                            ) {
                                ForEach(venueNotification.notifications, id: \.self) { ticket in
                                    NotificationCard(
                                        request: ticket,
                                        venue: venuesByID[venueNotification.venueID],
                                        onDelete: {
                                            Task {
                                                await viewModel.delete(ticket: ticket, from: venueNotification.venueID)
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
                                        Task { await viewModel.delete(venueNotification) }
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
            .task { await viewModel.load() }
            .sheet(isPresented: $viewModel.showDeleteError) {
                ErrorView(error: DeleteFailure())
            }
        }
    struct DeleteFailure: LocalizedError {
	    var errorDescription: String? {
	        "Failed to delete. Please try again later."
	    }
	}
}
