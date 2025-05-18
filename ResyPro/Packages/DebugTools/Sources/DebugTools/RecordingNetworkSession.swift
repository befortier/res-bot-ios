import Foundation
import Network

/// ``NetworkSession`` wrapper that records all requests and responses.
public final class RecordingNetworkSession: NetworkSession {
  private let wrapped: any NetworkSession
  private let store: NetworkHistoryStore

  /// Creates a new recording session.
  /// - Parameters:
  ///   - wrapped: The underlying ``NetworkSession`` to call.
  ///   - store: Store used to persist network history.
  public init(
    wrapped: any NetworkSession = URLSession.shared,
    store: NetworkHistoryStore = .shared
  ) {
    self.wrapped = wrapped
    self.store = store
  }

  public func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws
    -> (Data, URLResponse)
  {
    let startDate = Date()
    let requestBody = request.httpBody.flatMap { String(data: $0, encoding: .utf8) }
    var record = NetworkRecord(
      date: startDate,
      method: request.httpMethod ?? "GET",
      url: request.url?.absoluteString ?? "",
      requestHeaders: request.allHTTPHeaderFields,
      requestBody: requestBody
    )
    store.add(record)

    do {
      let (data, response) = try await wrapped.data(for: request, delegate: delegate)
      let statusCode = (response as? HTTPURLResponse)?.statusCode
      record.status = .finished
      record.statusCode = statusCode
      record.responseHeaders = (response as? HTTPURLResponse)?.allHeaderFields as? [String: String]
      record.responseBody = String(data: data, encoding: .utf8)
      store.update(record)
      return (data, response)
    } catch {
      record.status = .failed
      record.errorDescription = String(describing: error)
      store.update(record)
      throw error
    }
  }
}
