import DesignSystem
import SwiftUI

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
          Text(statusText(for: record))
            .font(.footnote)
            .foregroundColor(.secondary)
        }
      }
    }
    .navigationTitle("Network History")
  }

  private func statusText(for record: NetworkRecord) -> String {
    switch record.status {
    case .inProgress:
      return "Status: In Progress"
    case .failed:
      return "Status: Failed"
    case .finished:
      let code = record.statusCode.map { String($0) } ?? "Unknown"
      return "Status: \(code)"
    }
  }
}
