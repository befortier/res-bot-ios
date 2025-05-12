//
//  BulkNotificationFlowViewModel.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI
import Foundation
import Venues

@MainActor
public final class BulkNotificationFlowViewModel: ObservableObject {

    private let submitter: (BulkNotificationSubmissionRequest) async throws -> VenueSubmissionResult

    /// The list of venues available for selection.
    public let allVenues: [Venue]

    public init(
        allVenues: [Venue],
        submitter: @escaping (BulkNotificationSubmissionRequest) async throws -> VenueSubmissionResult
    ) {
        self.allVenues = allVenues
        self.submitter = submitter
    }

    /// Submits a bulk reservation notification request using the provided view state.
    public func submit(from state: BulkNotificationFlowView.ViewState) async throws -> VenueSubmissionResult {
        try await submitter(
            BulkNotificationSubmissionRequest(
                interval: state.dateInterval,
                partySizeRange: state.partySizeRange,
                venueIDs: Array(state.selectedVenueIDs)
            )
        )
    }
}
