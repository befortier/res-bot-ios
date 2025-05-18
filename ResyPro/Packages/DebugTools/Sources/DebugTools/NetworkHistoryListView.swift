import SwiftUI
import DesignSystem

/// Displays a list of recorded network calls.
public struct NetworkHistoryListView: View {
    @EnvironmentObject private var store: NetworkHistoryStore

    public init() {}

    public var body: some View {
        List(store.records.sorted(by: { $0.date > $1.date })) { record in
            NavigationLink {
                NetworkRecordDetailView(record: record)
            } label: {
                VStack(alignment: .leading) {
                    Text("\(record.method) \(record.url)")
                        .font(.design(.body))
                    Text(statusText(for: record))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Network History")
    }

    private func statusText(for record: NetworkRecord) -> String {
        switch record.state {
        case .pending: return "Pending"
        case .inProgress: return "In Progress"
        case .success: return "Status: \(record.statusCode)"
        case .failure: return record.errorDescription ?? "Failed"
        }
    }
}
