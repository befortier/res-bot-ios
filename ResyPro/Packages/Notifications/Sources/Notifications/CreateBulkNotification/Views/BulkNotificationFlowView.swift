//
//  BulkNotificationFlowView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import DesignSystem
import SwiftUI
import Venues
import Websockets

/// Container for the full bulk notification creation flow.
public struct BulkNotificationFlowView: View {
    @State private var viewState: ViewState
    @State private var confirmationKind: BulkNotificationConfirmationView.Kind?
    @State private var results: [NotificationSubmissionResponse.ResultEntry] = []
    @State private var expectedCount: Int?

    private let viewModel: BulkNotificationFlowViewModel
    @Environment(\.websocketClient) private var websocketClient

    /// Creates the bulk notification flow view.
    /// - Parameters:
    ///   - initialState: Optional starting state of the flow.
    ///   - viewModel: The view model responsible for submission logic.
    public init(
        initialState: ViewState? = nil,
        viewModel: BulkNotificationFlowViewModel
    ) {
        let calendar = Calendar.current
        let today = Date()
        let defaultStart =
        calendar.date(
            bySettingHour: 18,
            minute: 30,
            second: 0,
            of: today
        ) ?? today
        let defaultEnd =
        calendar.date(
            bySettingHour: 21,
            minute: 0,
            second: 0,
            of: today
        ) ?? defaultStart.addingTimeInterval(60 * 60 * 2.5)

        let startingState =
        initialState
        ?? ViewState(
            dateInterval: DateInterval(start: defaultStart, end: defaultEnd),
            partySizeRange: 2...4,
            selectedVenueIDs: Set(viewModel.allVenues.map(\.venueID))
        )
        self._viewState = State(initialValue: startingState)
        self.viewModel = viewModel
    }

    public var body: some View {
        Group {
            switch viewState.step {
            case .selectTime:
                timeAndPartySizeView
            case .selectVenues:
                bulkNotificationVenueSelectionView
            case .submitted:
                submissionResultsView
            }
        }
        .background(Color.backgroundPrimary)
        .sheet(item: $confirmationKind) { kind in
            BulkNotificationConfirmationView(kind: kind) {
                confirmationKind = nil
            }
        }
    }

    private var timeAndPartySizeView: some View {
        TimeAndPartySizeView(
            dateInterval: $viewState.dateInterval,
            partySizeRange: $viewState.partySizeRange
        ) {
            viewState.step = .selectVenues
        }
    }

    private var bulkNotificationVenueSelectionView: some View {
        BulkNotificationVenueSelectionView(
            allVenues: viewModel.allVenues,
            selectedVenueIDs: $viewState.selectedVenueIDs,
            dateInterval: viewState.dateInterval,
            partySizeRange: viewState.partySizeRange,
        ) {
            Task {
                do {
                    observeResults()
                    self.expectedCount = try await viewModel.submit(from: viewState)
                    results = []
                    viewState.step = .submitted(nil)
                } catch {
                    self.confirmationKind = .error
                }
            }
        }
        .safeAreaInset(edge: .top) {
            backButton
                .padding(.leading, 12)
        }
    }

    private var backButton: some View {
        Button {
            viewState.step = .selectTime
        } label: {
            Image(systemName: "chevron.left")
                .font(.design(.button).bold())
                .foregroundColor(.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var submissionResultsView: some View {
        SubmissionResultView(results: results, expectedCount: expectedCount)
            .onDisappear { results = [] }
    }

    private func observeResults() {
        Task {
            for await entry in await websocketClient.observeEvent(
                named: "notification-result",
                as: NotificationSubmissionResponse.ResultEntry.self
            ) {
                await MainActor.run {
                    withAnimation { results.append(entry) }
                    if let expectedCount, results.count >= expectedCount {
                        confirmationKind = .success
                        viewState.step = .selectTime
                    }
                }
                if let expectedCount, results.count >= expectedCount { break }
            }
        }
    }
}
