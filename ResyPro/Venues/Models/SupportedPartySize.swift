//
//  SupportedPartySize.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/24/24.
//

import Foundation
import SwiftData

@Model
final class SupportedPartySize: Equatable {
    var min: Int
    var max: Int
    @Relationship var venueSlot: VenueSlot?

    init(min: Int, max: Int) {
        self.min = min
        self.max = max
    }
}
