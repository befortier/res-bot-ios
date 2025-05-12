//
//  BulkNotificationFlowView+ViewState.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//


import Foundation

public extension BulkNotificationFlowView {
    /// Represents the complete state of the bulk notification creation flow.
    struct ViewState: Equatable {

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
            selectedVenueIDs: Set<Int> = []
        ) {
            self.step = step
            self.dateInterval = dateInterval
            self.partySizeRange = partySizeRange
            self.selectedVenueIDs = selectedVenueIDs
        }
    }
}
