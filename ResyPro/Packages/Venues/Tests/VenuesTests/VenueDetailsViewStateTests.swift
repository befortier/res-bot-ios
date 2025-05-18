import XCTest

@testable import Venues

@MainActor final class VenueDetailsViewStateTests: XCTestCase {
  func testInitFromVenue() {
    let venue = Venue.laserWolf
    let viewState = VenueDetailsViewState(venue: venue)
    XCTAssertEqual(viewState.name, venue.name)
    XCTAssertEqual(viewState.cuisineType, venue.cuisineType)
  }
}
