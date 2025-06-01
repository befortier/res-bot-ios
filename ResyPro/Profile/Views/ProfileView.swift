import DesignSystem
import Network
import Notifications
import ProjectFoundation
import SwiftUI
import User
import Venues
import Websockets
import SwiftData
import Authentication

struct ProfileView: View {
    @Environment(\.projectModelContainer) private var modelContainer: any ModelContainerProtocol
    @Environment(\.websocketClient) private var websocketClient
    @Query(sort: \Venue.name) private var venues: [Venue]
    @Environment(UserSession.self) var userSession

    private var logoutUseCase: any LogoutUseCase {
        LogoutUseCaseLive(
            container: modelContainer,
            websocketClient: websocketClient,
            websocketURL: URL.websocketServer,
            tokenStore: TokenStoreFile()
        )
    }

    private var notificationRepository: any NotificationRepository {
        NotificationRepositoryLive(
            networkService: BearerNetworkServiceComposer.make(
                userSession: userSession
            ),
            venueStore: VenueStoreLive(container: modelContainer),
            notificationsStore: NotificationsStoreLive(container: modelContainer)
        )
    }

    var body: some View {
        VStack(spacing: 16) {
            if let url = userSession.user.profileImageURL {
                ResizableImage(url: url)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 120, height: 120)
            }

            Text(userSession.user.name)
                .font(.design(.title3))
                .foregroundStyle(Color.textPrimary)

            Text(userSession.user.preferredLocation)
                .font(.design(.body))
                .foregroundStyle(Color.textSecondary)

            NavigationLink("Notifications") {
                NotificationListView(
                    venues: venues,
                    repository: notificationRepository
                )
            }

            Button("Logout") {
                Task { await logoutUseCase() }
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
    }
}
//
//#Preview {
//    ProfileView(user: .stub)
//}
