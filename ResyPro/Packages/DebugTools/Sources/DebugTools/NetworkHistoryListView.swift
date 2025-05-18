import SwiftUI
import DesignSystem

/// Displays a list of recorded network calls.
public struct NetworkHistoryListView: View {
    @EnvironmentObject private var store: NetworkHistoryStore
    @State private var searchText = ""

    public init() {}

    public var body: some View {
        List(filteredRecords) { record in
            NavigationLink(value: record) {
                HStack(alignment: .top) {
                    Circle()
                        .fill(color(for: record))
                        .frame(width: 8, height: 8)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(record.urlPath)
                            .font(.design(.body))
                        Text(record.date.formatted(date: .omitted, time: .standard))
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .navigationDestination(for: NetworkRecord.self) { record in
            NetworkRecordDetailView(record: record)
        }
        .navigationTitle("Network History")
    }

    private var filteredRecords: [NetworkRecord] {
        store.records
            .sorted { $0.date > $1.date }
            .filter { record in
                searchText.isEmpty ||
                record.url.localizedCaseInsensitiveContains(searchText) ||
                record.method.localizedCaseInsensitiveContains(searchText)
            }
    }

    private func color(for record: NetworkRecord) -> Color {
        switch record.state {
        case .success:
            return .success
        case .failure:
            return .error
        case .pending, .inProgress:
            return .warning
        }
    }
}

private extension NetworkRecord {
    var urlPath: String {
        URL(string: url)?.path ?? url
    }
}
