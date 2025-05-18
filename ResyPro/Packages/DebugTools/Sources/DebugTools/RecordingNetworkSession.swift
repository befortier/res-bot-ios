import Foundation
import Network

/// ``NetworkSession`` wrapper that records all requests and responses.
public struct RecordingNetworkSession: NetworkSession {
    private let wrapped: any NetworkSession
    private let store: NetworkHistoryStore

    /// Creates a new recording session.
    /// - Parameters:
    ///   - wrapped: The underlying ``NetworkSession`` to call.
    ///   - store: Store used to persist network history.
    public init(
        wrapped: any NetworkSession,
        store: NetworkHistoryStore = .shared
    ) {
        self.wrapped = wrapped
        self.store = store
    }

    public func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        let startDate = Date()
        let requestBody = request.httpBody.flatMap { String(data: $0, encoding: .utf8) }
        let (data, response) = try await wrapped.data(for: request, delegate: delegate)
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        let record = NetworkRecord(
            date: startDate,
            method: request.httpMethod ?? "GET",
            url: request.url?.absoluteString ?? "",
            statusCode: statusCode,
            requestHeaders: request.allHTTPHeaderFields,
            responseHeaders: (response as? HTTPURLResponse)?.allHeaderFields as? [String: String],
            requestBody: requestBody,
            responseBody: String(data: data, encoding: .utf8)
        )
        store.add(record)
        return (data, response)
    }
}
