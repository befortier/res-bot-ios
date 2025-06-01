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
    @Query(sort: \Notification.startTime)
    private var notifications: [Notification]

    private var mergedNotifications: [Date: [MergedVenueTicket]] {
        NotificationCalendarLogic.mergedByDate(from: notifications)
    }

    /// Creates the list view using a repository and known venues.
    /// - Parameters:
    ///   - venues: Lookup of venues associated with notifications.
    ///   - repository: Data source for notifications.
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
                VStack(spacing: 16) {
                    Image(systemName: "bell.slash")
                        .font(.system(size: 48))
                        .foregroundStyle(Color.textSecondary)
                    Text("You have no notifications")
                        .font(.design(.title3))
                        .foregroundStyle(Color.textSecondary)
                    Button("Refresh") {
                        Task { await viewModel.refresh() }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        .toolbar {
            Button {
                showBulkFlow = true
            } label: {
                Image(
                    systemName: "plus"
                )
            }
        }
        .sheet(isPresented: $showBulkFlow) {
            BulkNotificationFlowView(
                viewModel: BulkNotificationFlowViewModel(
                    allVenues: allVenues,
                    initialState: initialState(for: selectedDate),
                    submitter: { request in
                        try await repository.submit(request)
                    },
                    resultHandler: { entry in
                        if entry.success { try? repository.save(entry.request) }
                    }
                )
            )
        }
    }

    private func initialState(for date: Date) -> BulkNotificationFlowView.ViewState {
        let calendar = Calendar.current
        let start = calendar.date(bySettingHour: 18, minute: 30, second: 0, of: date) ?? date
        let end = calendar.date(bySettingHour: 21, minute: 0, second: 0, of: date)
            ?? start.addingTimeInterval(60 * 60 * 2.5)
        return BulkNotificationFlowView.ViewState(
            dateInterval: DateInterval(start: start, end: end),
            partySizeRange: 2...4,
            selectedVenueIDs: Set(allVenues.map(\.venueID))
        )
    }
}
