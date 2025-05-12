//
//  BulkNotificationFlowView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI
import DesignSystem
import Venues

/// Container for the full bulk notification creation flow.
public struct BulkNotificationFlowView: View {
    @State private var viewState: ViewState

    private let viewModel: BulkNotificationFlowViewModel

    public init(
        initialState: ViewState? = nil,
        viewModel: BulkNotificationFlowViewModel
    ) {
        let initialState =  initialState ?? ViewState(
            dateInterval: DateInterval(start: .now, duration: 3600),
            partySizeRange: 2...4,
            selectedVenueIDs: Set(viewModel.allVenues.map(\.venueID))
        )
        self._viewState = State(initialValue: initialState)
        self.viewModel = viewModel
    }

    public var body: some View {
        switch viewState.step {
        case .selectTime:
            TimeAndPartySizeView(
                dateInterval: $viewState.dateInterval,
                partySizeRange: $viewState.partySizeRange
            ) {
                viewState.step = .selectVenues
            }

        case .selectVenues:
            VenueSelectionView(
                allVenues: viewModel.allVenues,
                selectedVenueIDs: $viewState.selectedVenueIDs
            ) {
                Task {
                    do {
                        let results = try await viewModel.submit(from: viewState)
                        self.viewState.step = .submitted(results)
                    } catch {
                        // error state
                    }
                }
            }

        case .submitted(let result):
            SubmissionResultView(result: result)
        }
    }
}
