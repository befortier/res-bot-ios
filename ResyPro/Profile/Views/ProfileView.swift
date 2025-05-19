import DesignSystem
import Network
import Notifications
import ProjectFoundation
import SwiftUI
import User
import Venues
import Websockets

struct ProfileView: View {
  @Environment(\.projectModelContainer) private var modelContainer: any ModelContainerProtocol
  @Environment(\.websocketClient) private var websocketClient
  @Environment(\.tokenStore) private var tokenStore
  @Query(sort: \Venue.name) private var venues: [Venue]
  let user: User

  private var logoutUseCase: any LogoutUseCase {
    LogoutUseCaseLive(
      container: modelContainer,
      websocketClient: websocketClient,
      websocketURL: URL.websocketServer
    )
  }

  private var notificationRepository: any NotificationRepository {
    NotificationRepositoryLive(
      networkService: BearerNetworkServiceComposer.make(
        configuration: ResyHeaderConfiguration(user: user),
        refresher: AuthenticationRepositoryLive(
          networkService: NetworkServiceLive(),
          tokenStore: tokenStore
        )
      )
    )
  }

  var body: some View {
    VStack(spacing: 16) {
      if let url = user.profileImageURL {
        ResizableImage(url: url)
          .frame(width: 120, height: 120)
          .clipShape(Circle())
      } else {
        Circle()
          .fill(Color.gray.opacity(0.2))
          .frame(width: 120, height: 120)
      }

      Text(user.name)
        .font(.design(.title3))
        .foregroundStyle(Color.textPrimary)

      Text(user.preferredLocation)
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

#Preview {
  ProfileView(user: .stub)
}
