import Testing
@testable import Notifications

@MainActor
struct NotificationListViewModelTests {
    final class SpyRepository: NotificationRepository {
        var dateCalls = 0
        func submit(_ request: BulkNotificationSubmissionRequest) async throws {}
        func getNotificationsByVenue() async throws -> [VenueNotification] { [] }
        func getNotificationsByDate() async throws -> [DateNotification] {
            dateCalls += 1
            return []
        }
        func delete(_ requests: [DeleteNotificationRequest]) async throws {}
        func delete(_ request: DeleteNotificationRequest) async throws {}
    }

    @Test func testLoadFetchesNotificationsOnce() async {
        let repo = SpyRepository()
        let model = NotificationListViewModel(repository: repo)
        await model.load()
        await model.load()
        #expect(repo.dateCalls == 1)
    }
}
