//
//  Location.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/24/24.
//

import Foundation
import SwiftData

@Model
final class Location: Identifiable, Equatable {
    var id: String { self.urlSlug }
    var timeZone: String
    var neighborhood: String
    @Relationship(inverse: \Geo.location) var geo: Geo
    var code: String
    var name: String
    var urlSlug: String
    
    @Relationship var venue: Venue?

    init(
        timeZone: String,
        neighborhood: String,
        geo: GeoDTO,
        code: String,
        name: String,
        urlSlug: String
    ) {
        self.timeZone = timeZone
        self.neighborhood = neighborhood
        self.geo = Geo(
            latitude: geo.latitude,
            longitude: geo.longitude
        )
        self.code = code
        self.name = name
        self.urlSlug = urlSlug
    }

    convenience init(locationDTO: LocationDTO) {
        self.init(
            timeZone: locationDTO.timeZone,
            neighborhood: locationDTO.neighborhood,
            geo: locationDTO.geo,
            code: locationDTO.code,
            name: locationDTO.name,
            urlSlug: locationDTO.urlSlug
        )
    }
}


