//
//  BulkNotificationFlowView+ViewState.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import Foundation
import Venues

extension BulkNotificationFlowView {
  /// Represents the complete state of the bulk notification creation flow.
  public struct ViewState: Equatable {

    /// The current step in the flow.
    public enum Step: Equatable, Sendable {
      case selectTime
      case selectVenues
      case submitted(NotificationSubmissionResponse?)
    }

    /// Current step in the UI flow.
    public var step: Step

    /// The reservation interval selected by the user.
    public var dateInterval: DateInterval

    /// The desired party size range, e.g., 2...6.
    public var partySizeRange: ClosedRange<Int>

    /// The venue IDs selected for notification.
    public var selectedVenueIDs: Set<Int>

    public init(
      step: Step = .selectTime,
      dateInterval: DateInterval,
      partySizeRange: ClosedRange<Int>,
      selectedVenueIDs: Set<Venue.ID> = []
    ) {
      self.step = step
      self.dateInterval = dateInterval
      self.partySizeRange = partySizeRange
      self.selectedVenueIDs = selectedVenueIDs
    }
  }
}

extension BulkNotificationFlowView.ViewState {
    static func initialState(
        venueIDs: Set<Venue.ID>,
        for date: Date = .now
    ) -> BulkNotificationFlowView.ViewState {
        let calendar = Calendar.current
        let start = calendar.date(bySettingHour: 18, minute: 30, second: 0, of: date) ?? date
        let end = calendar.date(bySettingHour: 21, minute: 0, second: 0, of: date)
            ?? start.addingTimeInterval(60 * 60 * 2.5)
        return BulkNotificationFlowView.ViewState(
            dateInterval: DateInterval(start: start, end: end),
            partySizeRange: 2...4,
            selectedVenueIDs: venueIDs,
        )
    }
}
