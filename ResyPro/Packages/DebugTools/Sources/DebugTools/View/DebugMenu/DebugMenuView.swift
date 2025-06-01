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
                NavigationLink("Websocket History") {
                    WebsocketHistoryListView()
                }
                NavigationLink("Swift Data") {
                    SwiftDataMenuView()
                }
            }
            .navigationTitle("Debug Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        DebugMenuPresenter.shared.dismiss()
                    }
                }
            }
        }
    }
}
