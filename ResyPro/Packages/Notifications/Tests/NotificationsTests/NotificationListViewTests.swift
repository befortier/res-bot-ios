import Testing
@testable import Notifications
@testable import Venues

@MainActor
struct NotificationListViewTests {
	class SpyRepository: NotificationRepository {
	    var deletedSingle: [DeleteNotificationRequest] = []
	    var deletedBulk: [[DeleteNotificationRequest]] = []

	    func submit(_ request: BulkNotificationSubmissionRequest) async throws {}
	    func getAllNotifications() async throws -> [VenueNotification] { [] }
	    func delete(_ requests: [DeleteNotificationRequest]) async throws {
	        deletedBulk.append(requests)
	    }
	    func delete(_ request: DeleteNotificationRequest) async throws {
	        deletedSingle.append(request)
	    }
	}

	@Test func testRemoveSingleTicketUpdatesState() {
	    let repo = SpyRepository()
	    var view = NotificationListView(venues: [.laserWolf], repository: repo)
	    let interval = DateInterval(start: .now, duration: 3600)
	    let ticket = NotificationTicket(venueID: 1, interval: interval, partySize: 2)
	    view.state = .success([VenueNotification(venueID: 1, notifications: [ticket])])
	    view.remove(ticket: ticket, from: 1)
	    if case .success(let notes) = view.state {
	        #expect(notes.isEmpty)
	    } else {
	        Issue.record("Unexpected state")
	    }
	}

	@Test func testRemoveVenueUpdatesState() {
	    let repo = SpyRepository()
	    var view = NotificationListView(venues: [.laserWolf], repository: repo)
	    let interval = DateInterval(start: .now, duration: 3600)
	    let ticket = NotificationTicket(venueID: 1, interval: interval, partySize: 2)
	    view.state = .success([VenueNotification(venueID: 1, notifications: [ticket])])
	    view.remove(venueID: 1)
	    if case .success(let notes) = view.state {
	        #expect(notes.isEmpty)
	    } else {
	        Issue.record("Unexpected state")
	    }
	}
}
