import Foundation

/// Captures a single network request and response pair.
public struct NetworkRecord: Codable, Identifiable {
  /// Possible lifecycle states of a network call.
  public enum Status: String, Codable {
    case inProgress
    case failed
    case finished
  }

  /// The unique identifier for the record.
  public let id: UUID
  /// Timestamp of when the request was executed.
  public let date: Date
  /// HTTP method used for the request.
  public let method: String
  /// Absolute string of the requested URL.
  public let url: String
  /// Current lifecycle state of the call.
  public var status: Status
  /// HTTP status code returned by the server, if any.
  public var statusCode: Int?
  /// Request headers at the time of the call.
  public let requestHeaders: [String: String]?
  /// Response headers returned by the server, if any.
  public var responseHeaders: [String: String]?
  /// Optional body sent with the request.
  public let requestBody: String?
  /// Optional body returned in the response, if any.
  public var responseBody: String?
  /// Optional error description for failed requests.
  public var errorDescription: String?

  public init(
    id: UUID = UUID(),
    date: Date = Date(),
    method: String,
    url: String,
    status: Status = .inProgress,
    statusCode: Int? = nil,
    requestHeaders: [String: String]? = nil,
    responseHeaders: [String: String]? = nil,
    requestBody: String? = nil,
    responseBody: String? = nil,
    errorDescription: String? = nil
  ) {
    self.id = id
    self.date = date
    self.method = method
    self.url = url
    self.status = status
    self.statusCode = statusCode
    self.requestHeaders = requestHeaders
    self.responseHeaders = responseHeaders
    self.requestBody = requestBody
    self.responseBody = responseBody
    self.errorDescription = errorDescription
  }
}
