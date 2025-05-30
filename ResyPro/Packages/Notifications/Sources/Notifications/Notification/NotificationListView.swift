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
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                FunChip(
                    title: "By Venue",
                    isSelected: viewModel.filter == .venue
                ) {
                    viewModel.filter = .venue
                }
                FunChip(
                    title: "By Date",
                    isSelected: viewModel.filter == .date
                ) {
                    viewModel.filter = .date
                }
            }

            switch viewModel.filter {
            case .venue:
                ScrollView {
                    VStack(spacing: 12) {
                        switch viewModel.venueState {
                        case .loading:
                            DefaultProgressView()
                        case .failed(let error):
                            ErrorView(error: error)
                        case .success(let venueNotifications):
                            ForEach(venueNotifications) { venueNotification in
                                VenueNotificationCard(
                                    venueNotification: venueNotification,
                                    venue: venuesByID[venueNotification.venueID],
                                    isExpanded: Binding(
                                        get: { viewModel.expanded.contains(venueNotification.id) },
                                        set: { isExpanded in
                                            if isExpanded { viewModel.expanded.insert(venueNotification.id) }
                                            else { viewModel.expanded.remove(venueNotification.id) }
                                        }
                                    ),
                                    onDeleteTicket: { ticket in
                                        Task { await viewModel.delete(ticket: ticket, from: venueNotification.venueID) }
                                    },
                                    onDeleteVenue: {
                                        Task { await viewModel.delete(venueNotification) }
                                    }
                                )
                            }
                        }
                    }
                    .padding()
                }
            case .date:
                switch viewModel.dateState {
                case .loading:
                    DefaultProgressView()
                case .failed(let error):
                    ErrorView(error: error)
                case .success(let notifications):
                    NotificationCalendarView(notifications: notifications, venuesByID: venuesByID)
                        .padding()
                }
            }
        }
        .task { await viewModel.load() }
        .onChange(of: viewModel.filter) { _, _ in
            Task { await viewModel.load() }
        }
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
