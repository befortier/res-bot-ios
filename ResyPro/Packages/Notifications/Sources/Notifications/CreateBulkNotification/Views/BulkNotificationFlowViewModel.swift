//
//  BulkNotificationFlowViewModel.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import Foundation
import SwiftUI
import Venues

/// Coordinates data and submission logic for ``BulkNotificationFlowView``.
@MainActor
public struct BulkNotificationFlowViewModel {

  private let submitter:
    (BulkNotificationSubmissionRequest) async throws -> NotificationSubmissionResponse

  /// The list of venues available for selection.
  public let allVenues: [Venue]

  /// Creates a new view model.
  /// - Parameters:
  ///   - allVenues: The list of venues the user can choose from.
  ///   - submitter: A closure that performs the network request to create the notifications.
  public init(
    allVenues: [Venue],
    submitter: @escaping (BulkNotificationSubmissionRequest) async throws ->
      NotificationSubmissionResponse
  ) {
    self.allVenues = allVenues
    self.submitter = submitter
  }

  /// Submits a bulk reservation notification request using the provided view state.
  /// - Parameter state: The current UI state describing the user's selections.
  /// - Returns: The submission response from the server.
  public func submit(from state: BulkNotificationFlowView.ViewState) async throws
    -> NotificationSubmissionResponse
  {
    try await submitter(
      BulkNotificationSubmissionRequest(
        interval: state.dateInterval,
        partySizeRange: state.partySizeRange,
        venueIDs: Array(state.selectedVenueIDs)
      )
    )
  }
}
