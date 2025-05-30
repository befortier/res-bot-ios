import Testing
@testable import Notifications
@testable import Venues

@MainActor
struct NotificationListViewModelTests {
	class SpyRepository: NotificationRepository {
	    var deletedSingle: [DeleteNotificationRequest] = []
	    var deletedBulk: [[DeleteNotificationRequest]] = []

	    func submit(_ request: BulkNotificationSubmissionRequest) async throws {}
            func getNotificationsByVenue() async throws -> [VenueNotification] { [] }
            func getNotificationsByDate() async throws -> [DateNotification] { [] }
	    func delete(_ requests: [DeleteNotificationRequest]) async throws {
	        deletedBulk.append(requests)
	    }
	    func delete(_ request: DeleteNotificationRequest) async throws {
	        deletedSingle.append(request)
	    }
	}

        @Test func testRemoveSingleTicketUpdatesState() {
            let repo = SpyRepository()
            let model = NotificationListViewModel(repository: repo)
            let interval = DateInterval(start: .now, duration: 3600)
            let ticket = NotificationTicket(venueID: 1, interval: interval, partySize: 2)
            model.venueState = .success([VenueNotification(venueID: 1, notifications: [ticket])])
            model.remove(ticket: ticket, from: 1)
            if case .success(let notes) = model.venueState {
                #expect(notes.isEmpty)
            } else {
                Issue.record("Unexpected state")
            }
        }

        @Test func testRemoveVenueUpdatesState() {
            let repo = SpyRepository()
            let model = NotificationListViewModel(repository: repo)
            let interval = DateInterval(start: .now, duration: 3600)
            let ticket = NotificationTicket(venueID: 1, interval: interval, partySize: 2)
            model.venueState = .success([VenueNotification(venueID: 1, notifications: [ticket])])
            model.remove(venueID: 1)
            if case .success(let notes) = model.venueState {
                #expect(notes.isEmpty)
            } else {
                Issue.record("Unexpected state")
            }
        }
}
