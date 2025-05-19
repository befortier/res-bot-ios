import Foundation
import SwiftUI
import Venues
import Websockets

/// Coordinates data and submission logic for ``BulkNotificationFlowView``.
@MainActor
public final class BulkNotificationFlowViewModel: ObservableObject {
    /// Current state of the bulk notification flow.
    @Published public var state: BulkNotificationFlowView.ViewState
    /// Results streamed back from the server.
    @Published public var results: [NotificationSubmissionResponse.ResultEntry] = []
    /// Expected total number of results if known.
    @Published public var expectedCount: Int?
    /// Indicates whether more results are expected.
    @Published public var isReceivingResults = false

    private let submitter: (BulkNotificationSubmissionRequest) async throws -> Void
    /// The list of venues available for selection.
    public let allVenues: [Venue]

    /// Creates a new view model.
    /// - Parameters:
    ///   - allVenues: The list of venues the user can choose from.
    ///   - initialState: Optional starting UI state. If `nil` a default is created.
    ///   - submitter: Performs the network request to create the notifications.
    public init(
        allVenues: [Venue],
        initialState: BulkNotificationFlowView.ViewState? = nil,
        submitter: @escaping (BulkNotificationSubmissionRequest) async throws -> Void
    ) {
        self.allVenues = allVenues
        self.submitter = submitter

        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date()) ?? .now

        let defaultStart = calendar.date(bySettingHour: 18, minute: 30, second: 0, of: tomorrow) ?? tomorrow
        let defaultEnd =
        calendar.date(bySettingHour: 21, minute: 0, second: 0, of: tomorrow)
        ?? defaultStart.addingTimeInterval(60 * 60 * 2.5)

        self.state =
        initialState
        ?? BulkNotificationFlowView.ViewState(
            dateInterval: DateInterval(start: defaultStart, end: defaultEnd),
            partySizeRange: 2...4,
            selectedVenueIDs: Set(allVenues.map(\.venueID))
        )
    }

    /// Submits the current state to the backend and begins observing results.
    /// - Parameter client: The websocket client used to stream results.
    public func submit(using client: any WebsocketClient) async throws {
        isReceivingResults = true
        results = []
        try await submitter(
            BulkNotificationSubmissionRequest(
                interval: state.dateInterval,
                partySizeRange: state.partySizeRange,
                venueIDs: Array(state.selectedVenueIDs)
            )
        )
        expectedCount = state.selectedVenueIDs.count * abs(state.partySizeRange.upperBound.distance(to: state.partySizeRange.lowerBound))
        state.step = .submitted(nil)
        Task { await observeResults(client: client) }
    }

    /// Clears any collected results and returns to the first step.
    public func reset() {
        results = []
        expectedCount = nil
        state.step = .selectTime
    }

    // MARK: - Private

    private func observeResults(client: any WebsocketClient) async {
        for await entry in await client.notificationResultStream() {
            withAnimation { results.append(entry) }
            if let expectedCount, results.count >= expectedCount { break }
        }
        isReceivingResults = false
    }
}
