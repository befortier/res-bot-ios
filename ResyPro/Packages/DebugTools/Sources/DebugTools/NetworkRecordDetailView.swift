import DesignSystem
import SwiftUI

/// Presents detailed information about a specific network call.
public struct NetworkRecordDetailView: View {
  private let record: NetworkRecord
  @State private var selectedTab: Tab = .request

  public init(record: NetworkRecord) {
    self.record = record
  }

  public var body: some View {
    VStack {
      Picker("", selection: $selectedTab) {
        ForEach(Tab.allCases, id: \ .. self) { tab in
          Text(tab.rawValue).tag(tab)
        }
      }
      .pickerStyle(.segmented)

      ScrollView {
        content(for: selectedTab)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()
      }
      .textSelection(.enabled)
    }
    .navigationTitle("Details")
  }

  @ViewBuilder
  private func content(for tab: Tab) -> some View {
    switch tab {
    case .request:
      requestView
    case .response:
      responseView
    }
  }

  private var requestView: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("\(record.method) \(record.url)")
        .font(.design(.body))
      if let headers = record.requestHeaders {
        KeyValueList(headers)
      }
      if let body = record.requestBody {
        Text(prettyJSON(body))
          .font(.footnote)
      }
    }
  }

  private var responseView: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("Status: \(record.statusCode)")
        .font(.design(.body))
      if let headers = record.responseHeaders {
        KeyValueList(headers)
      }
      if let body = record.responseBody {
        Text(prettyJSON(body))
          .font(.footnote)
      }
    }
  }

  private func prettyJSON(_ string: String) -> String {
    guard let data = string.data(using: .utf8),
      let object = try? JSONSerialization.jsonObject(with: data),
      let pretty = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
      let result = String(data: pretty, encoding: .utf8)
    else {
      return string
    }
    return result
  }

  private enum Tab: String, CaseIterable {
    case request = "Request"
    case response = "Response"
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
