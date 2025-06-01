import Foundation
import ProjectFoundation
import SwiftUI

/// Coordinates data and actions for ``NotificationListView``.
@MainActor
public final class NotificationListViewModel: ObservableObject {
    /// Notifications grouped by date.
    @Published public private(set) var dateState: RemoteViewState<[DateNotification]> = .loading

    /// Controls display of a delete error alert.
    @Published public var showDeleteError = false

    private let repository: any NotificationRepository

    /// Creates a new view model.
    /// - Parameter repository: Source for notification data.
    public init(repository: any NotificationRepository) {
        self.repository = repository
    }

    /// Loads notifications from the repository.
    ///
    /// Results are cached for the lifetime of this view model so repeated calls
    /// while the view is active will not trigger additional network requests.
    public func load() async {
        if case .success = dateState { return }
        await loadByDate()
    }

    private func loadByDate() async {
        do {
            let notes = try await repository.getNotificationsByDate()
            dateState = .success(notes)
        } catch {
            dateState = .failed(error)
        }
    }
}
