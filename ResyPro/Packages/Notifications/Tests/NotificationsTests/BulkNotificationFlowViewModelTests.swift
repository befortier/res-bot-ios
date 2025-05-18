import XCTest

@testable import Notifications
@testable import Venues

final class BulkNotificationFlowViewModelTests: XCTestCase {
  func testSubmitPassesSelectedVenues() async throws {
    let venues = await [Venue.laserWolf]
    var capturedRequest: BulkNotificationSubmissionRequest?
    let model = BulkNotificationFlowViewModel(allVenues: venues) { request in
      capturedRequest = request
      return NotificationSubmissionResponse(interval: request.interval, results: [])
    }
    let interval = DateInterval(start: .now, duration: 3600)
    let state = BulkNotificationFlowView.ViewState(
      dateInterval: interval,
      partySizeRange: 2...4,
      selectedVenueIDs: [venues[0].venueID]
    )
    _ = try await model.submit(from: state)
    XCTAssertEqual(capturedRequest?.venueIDs, [venues[0].venueID])
  }
}
