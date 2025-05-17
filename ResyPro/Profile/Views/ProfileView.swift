import SwiftUI
import DesignSystem
import User

struct ProfileView: View {
    let user: User

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
        }
        .padding()
    }
}

#Preview {
    ProfileView(user: .stub)
}
