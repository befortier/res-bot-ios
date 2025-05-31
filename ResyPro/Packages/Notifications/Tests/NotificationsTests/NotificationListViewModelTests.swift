import Testing
@testable import Notifications
@testable import Venues

@MainActor
struct NotificationListViewModelTests {
        class SpyRepository: NotificationRepository {
            var deletedSingle: [DeleteNotificationRequest] = []
            var deletedBulk: [[DeleteNotificationRequest]] = []
            var venueCalls = 0
            var dateCalls = 0

            func submit(_ request: BulkNotificationSubmissionRequest) async throws {}
            func getNotificationsByVenue() async throws -> [VenueNotification] {
                venueCalls += 1
                return []
            }
            func getNotificationsByDate() async throws -> [DateNotification] {
                dateCalls += 1
                return []
            }
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

        @Test func testLoadCachesByVenue() async {
            let repo = SpyRepository()
            let model = NotificationListViewModel(repository: repo)
            model.filter = .venue
            await model.load()
            await model.load()
            #expect(repo.venueCalls == 1)
        }

        @Test func testLoadCachesByDate() async {
            let repo = SpyRepository()
            let model = NotificationListViewModel(repository: repo)
            model.filter = .date
            await model.load()
            model.filter = .venue
            await model.load()
            model.filter = .date
            await model.load()
            #expect(repo.dateCalls == 1)
        }
}
