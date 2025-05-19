import DesignSystem
import ProjectFoundation
import SwiftUI
import Venues

/// Displays a user's existing notifications.
public struct NotificationListView: View {
  @State private var state: RemoteViewState<[NotificationSubmissionResponse.RequestResult]> =
    .loading
  private let repository: any NotificationRepository
  private let venuesByID: [Int: Venue]

  /// Creates the list view using a repository and known venues.
  /// - Parameters:
  ///   - venues: Lookup of venues associated with notifications.
  ///   - repository: Data source for notifications.
  public init(venues: [Venue], repository: any NotificationRepository) {
    self.venuesByID = Dictionary(uniqueKeysWithValues: venues.map { ($0.venueID, $0) })
    self.repository = repository
  }

  public var body: some View {
    ScrollView {
      VStack(spacing: 12) {
        switch state {
        case .loading:
          DefaultProgressView()
        case .failed(let error):
          ErrorView(error: error)
        case .success(let notifications):
          ForEach(notifications, id: \._self) { request in
            NotificationCard(
              request: request,
              venue: venuesByID[request.venueID],
              style: .default
            )
          }
        }
      }
      .padding()
    }
    .task { await load() }
  }

  private func load() async {
    do {
      let notes = try await repository.getAllNotifications()
      state = .success(notes)
    } catch {
      state = .failed(error)
    }
  }
}
