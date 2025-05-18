import DesignSystem
import SwiftUI

/// Presents detailed information about a specific network call.
public struct NetworkRecordDetailView: View {
  private let record: NetworkRecord

  public init(record: NetworkRecord) {
    self.record = record
  }

  public var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 12) {
        Section(header: Text("Request")) {
          Text("\(record.method) \(record.url)")
            .font(.design(.body))
          if let headers = record.requestHeaders {
            KeyValueList(headers)
          }
          if let body = record.requestBody {
            Text(body)
              .font(.footnote)
          }
        }
        Divider()
        Section(header: Text("Response")) {
          Text(statusText())
            .font(.design(.body))
          if let headers = record.responseHeaders {
            KeyValueList(headers)
          }
          if let body = record.responseBody {
            Text(body)
              .font(.footnote)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding()
    }
    .navigationTitle("Details")
  }

  private func statusText() -> String {
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

private struct KeyValueList: View {
  let pairs: [KeyValue]
  init(_ dictionary: [String: String]) {
    self.pairs = dictionary.map { KeyValue(key: $0.key, value: $0.value) }
  }
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      ForEach(pairs) { pair in
        HStack(alignment: .top) {
          Text(pair.key + ":")
            .font(.footnote)
            .foregroundColor(.secondary)
          Text(pair.value)
            .font(.footnote)
        }
      }
    }
  }

  struct KeyValue: Identifiable {
    let id = UUID()
    let key: String
    let value: String
  }
}
