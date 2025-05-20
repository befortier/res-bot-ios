import XCTest
@testable import Venues

final class VenueCardViewStateMapperTests: XCTestCase {
	func testHorizontalMapping() {
		let viewState = VenueCardViewStateMapper().horizontal(venue: .laserWolf)
		XCTAssertEqual(viewState.name, Venue.laserWolf.name)
		XCTAssertEqual(viewState.locationName, Venue.laserWolf.location.name)
	}

	func testVerticalMapping() {
		let viewState = VenueCardViewStateMapper().vertical(venue: .laserWolf)
		XCTAssertEqual(viewState.name, Venue.laserWolf.name)
		XCTAssertEqual(viewState.neighborhood, Venue.laserWolf.location.neighborhood)
	}
}
