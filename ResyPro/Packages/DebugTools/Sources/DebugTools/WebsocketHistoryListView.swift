import SwiftUI
import DesignSystem

/// Displays a list of recorded websocket events.
public struct WebsocketHistoryListView: View {
    @EnvironmentObject private var store: WebsocketHistoryStore
    @State private var searchText = ""

    public init() {}

    public var body: some View {
        List(filteredRecords) { record in
            NavigationLink {
                WebsocketRecordDetailView(record: record)
            } label: {
                websocketCard(for: record)
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Websocket History")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(role: .destructive) { store.clear() } label: {
                    Image(systemName: "trash")
                }
                .disabled(store.records.isEmpty)
            }
        }
    }

    private func websocketCard(for record: WebsocketRecord) -> some View {
        HStack(alignment: .top) {
            Circle()
                .fill(record.direction == .sent ? Color.blue : Color.green)
                .frame(width: 8, height: 8)
            VStack(alignment: .leading, spacing: 2) {
                Text(record.name)
                    .font(.design(.body))
                Text(record.date.formatted(date: .omitted, time: .standard))
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }

    private var filteredRecords: [WebsocketRecord] {
        store.records
            .sorted { $0.date > $1.date }
            .filter { record in
                searchText.isEmpty ||
                record.name.localizedCaseInsensitiveContains(searchText)
            }
    }
}
