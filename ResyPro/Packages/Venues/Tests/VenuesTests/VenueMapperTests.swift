import XCTest

@testable import Venues

final class VenueMapperTests: XCTestCase {
  func testMapCreatesVenue() {
    let dto = VenueDTO(
      venueID: 1,
      name: "Test",
      location: LocationDTO(
        timeZone: "EST",
        neighborhood: "Brooklyn",
        geo: GeoDTO(latitude: 0, longitude: 0),
        code: "bk",
        name: "brooklyn",
        urlSlug: "bk"
      ),
      images: [],
      slots: [],
      needToKnow: nil,
      cuisineType: "Pizza",
      priceRange: 2,
      urlSlug: "test",
      bookingInfo: nil
    )

    let venue = VenueMapperLive().map(dto: dto)
    XCTAssertEqual(venue.name, dto.name)
    XCTAssertEqual(venue.venueID, dto.venueID)
  }
}
