import DesignSystem
import ProjectFoundation
import SwiftData
import SwiftUI
import Venues

/// Displays a user's existing notifications.
public struct NotificationListView: View {
    @StateObject private var viewModel: NotificationListViewModel
    private let venuesByID: [Int: Venue]
    private let allVenues: [Venue]
    private let repository: any NotificationRepository
    @State private var calendarMode: CalendarGridView.Mode = .month
    @State private var selectedDate: Date = .now
    @State private var showBulkFlow = false
    @Query(sort: \Notification.venue.name)
    private var notifications: [Notification]

    private var mergedNotifications: [Date: [MergedVenueTicket]] {
        NotificationCalendarLogic.mergedByDate(from: notifications)
    }

    public init(
        venues: [Venue],
        repository: any NotificationRepository
    ) {
        self.allVenues = venues
        self.venuesByID = Dictionary(uniqueKeysWithValues: venues.map { ($0.venueID, $0) })
        self.repository = repository
        _viewModel = StateObject(wrappedValue: NotificationListViewModel(repository: repository))
    }

    public var body: some View {
        Group {
            if notifications.isEmpty {
                EmptyView(
                    viewState: .init(
                        image: Image(systemName: "bell.slash"),
                        title: "You have no notifications",
                        buttonTitle: "Refresh"
                    )
                ) {
                    await viewModel.refresh()
                }
            } else {
                NotificationCalendarView(
                    venuesByID: venuesByID,
                    merged: mergedNotifications,
                    mode: $calendarMode,
                    selectedDate: $selectedDate
                )
            }
        }
        .task { await viewModel.load() }
        .refreshable { await viewModel.refresh() }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            createBulkNotificationButton
        }
        .sheet(isPresented: $showBulkFlow) {
            bulkNotificationFlowView
        }
    }

    private var bulkNotificationFlowView: some View {
        BulkNotificationFlowView(
            viewModel: BulkNotificationFlowViewModel(
                allVenues: allVenues,
                initialState: .initialState(venueIDs: Set(allVenues.map(\.venueID))),
                submitter: { request in
                    try await repository.submit(request)
                },
                resultHandler: { entry in
                    if entry.success { try? repository.save(entry.request) }
                }
            )
        )
    }

    private var createBulkNotificationButton: some View {
        Button {
            showBulkFlow = true
        } label: {
            Image(
                systemName: "plus"
            )
        }
    }
}
