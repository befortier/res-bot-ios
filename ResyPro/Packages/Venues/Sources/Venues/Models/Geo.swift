//
//  Geo.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData

@Model
public final class Geo: Equatable {
    public var latitude: Double
    public var longitude: Double
    @Relationship public var location: Location?

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
