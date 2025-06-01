import SwiftUI
import User
import Venues
import Notifications

/// Root view for browsing SwiftData entities.
public struct SwiftDataMenuView: View {
    public init() {}

    public var body: some View {
        List {
            NavigationLink("User") {
                SwiftDataEntityListView<User>()
            }
            NavigationLink("Venue") {
                SwiftDataEntityListView<Venue>()
            }
            NavigationLink("Notification") {
                SwiftDataEntityListView<Notifications.Notification>()
            }
        }
        .navigationTitle("Swift Data")
    }
}
