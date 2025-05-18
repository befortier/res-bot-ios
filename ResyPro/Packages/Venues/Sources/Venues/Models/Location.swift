//
//  Location.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData

@Model
/// Represents a physical city and neighborhood for a venue.
public final class Location: Identifiable, Equatable {
  public var id: String { self.urlSlug }
  public var timeZone: String
  public var neighborhood: String
  @Relationship(inverse: \Geo.location) public var geo: Geo
  public var code: String
  public var name: String
  public var urlSlug: String

  @Relationship var venue: Venue?

  public init(
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
