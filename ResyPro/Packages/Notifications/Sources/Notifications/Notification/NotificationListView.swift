import DesignSystem
import ProjectFoundation
import SwiftUI
import Venues

/// Displays a user's existing notifications.
public struct NotificationListView: View {
    @State private var state: RemoteViewState<[VenueNotification]> =
        .loading
    @State private var expanded: Set<Int> = []
    private let repository: any NotificationRepository
    private let venuesByID: [Int: Venue]
    
    /// Creates the list view using a repository and known venues.
    /// - Parameters:
    ///   - venues: Lookup of venues associated with notifications.
    ///   - repository: Data source for notifications.
    public init(
        venues: [Venue],
        repository: any NotificationRepository
    ) {
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
                case .success(let venueNotifications):
                    ForEach(venueNotifications) { venueNotification in
                        DisclosureGroup(
                            isExpanded: Binding(
                                get: { expanded.contains(venueNotification.id) },
                                set: { isExpanded in
                                    if isExpanded { expanded.insert(venueNotification.id) }
                                    else { expanded.remove(venueNotification.id) }
                                }
                            )
                        ) {
                            ForEach(venueNotification.notifications, id: \.self) { ticket in
                                NotificationCard(
                                    request: ticket,
                                    venue: venuesByID[venueNotification.venueID],
                                    onDelete: {
                                        Task {
                                            let req = DeleteNotificationRequest(
                                                venueID: ticket.venueID,
                                                startTime: ticket.interval.start,
                                                partySize: ticket.partySize
                                            )
                                            try? await repository.delete(req)
                                        }
                                    }
                                )
                            }
                        } label: {
                            HStack {
                                HorizontalVenueCard(
                                    model: HorizontalVenueCardModel(venue: venuesByID[venueNotification.venueID]!)
                                )
                                Spacer()
                                Button {
                                    Task {
                                        let requests = venueNotification.notifications.map {
                                            DeleteNotificationRequest(
                                                venueID: $0.venueID,
                                                startTime: $0.interval.start,
                                                partySize: $0.partySize
                                            )
                                        }
                                        try? await repository.delete(requests)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .buttonStyle(.borderless)
                            }
                        }
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
