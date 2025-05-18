import SwiftUI
import DesignSystem

/// Root debug menu listing available debug tools.
public struct DebugMenuView: View {
    public init() {}

    public var body: some View {
        NavigationStack {
            List {
                NavigationLink("Network History") {
                    NetworkHistoryListView()
                }
            }
            .navigationTitle("Debug Menu")
        }
    }
}
