//
//  VenueDetailsView+Action.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

public extension VenueDetailsView {
    /// A closure that handles actions from this view.
    public typealias ActionHandler = @MainActor (Action) -> Void

    /// Represents user actions that can be triggered from the venue details screen.
    enum Action: Equatable, Sendable {
        /// User tapped to create a notification when a reservation becomes available.
        case notifyMe

        /// User tapped to schedule a reservation automation bot.
        case scheduleBot

        /// User tapped to browse available reservation slots.
        case seeAvailability
    }
}
