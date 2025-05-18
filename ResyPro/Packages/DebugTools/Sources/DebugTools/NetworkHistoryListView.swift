import SwiftUI
import DesignSystem

/// Displays a list of recorded network calls.
public struct NetworkHistoryListView: View {
    @Environment(\.networkHistoryStore) private var store

    public init() {}

    public var body: some View {
        List(store.records.sorted(by: { $0.date > $1.date })) { record in
            NavigationLink(value: record) {
                VStack(alignment: .leading) {
                    Text("\(record.method) \(record.url)")
                        .font(.design(.body))
                    Text("Status: \(record.statusCode)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationDestination(for: NetworkRecord.self) { record in
            NetworkRecordDetailView(record: record)
        }
        .navigationTitle("Network History")
    }
}
