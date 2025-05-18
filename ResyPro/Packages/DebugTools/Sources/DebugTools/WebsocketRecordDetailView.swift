import SwiftUI
import DesignSystem

/// Presents detailed information about a specific websocket event.
public struct WebsocketRecordDetailView: View {
    private let record: WebsocketRecord

    public init(record: WebsocketRecord) {
        self.record = record
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(record.name)
                    .font(.design(.body))
                Text(record.direction == .sent ? "Sent" : "Received")
                    .font(.design(.body))
                if let payload = record.payload {
                    Text(prettyJSON(payload))
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle("Details")
    }

    private func prettyJSON(_ string: String) -> String {
        guard let data = string.data(using: .utf8),
              let object = try? JSONSerialization.jsonObject(with: data),
              let pretty = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
              let result = String(data: pretty, encoding: .utf8) else {
            return string
        }
        return result
    }
}
