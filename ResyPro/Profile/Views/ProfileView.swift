import SwiftUI
import DesignSystem
import User
import Websockets
import ProjectFoundation

struct ProfileView: View {
    @Environment(\.projectModelContainer) private var modelContainer: any ModelContainerProtocol
    @Environment(\.websocketClient) private var websocketClient
    let user: User

    private var logoutUseCase: any LogoutUseCase {
        LogoutUseCaseLive(
            container: modelContainer,
            websocketClient: websocketClient,
            websocketURL: URL.websocketServer
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
