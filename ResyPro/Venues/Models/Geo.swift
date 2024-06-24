//
//  Geo.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/24/24.
//

import Foundation
import SwiftData

@Model
final class Geo: Equatable {
    var latitude: Double
    var longitude: Double
    @Relationship var location: Location?

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
