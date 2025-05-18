import Foundation

/// Captures a single network request and response pair.
public struct NetworkRecord: Codable, Identifiable {
    /// The unique identifier for the record.
    public let id: UUID
    /// Timestamp of when the request was executed.
    public let date: Date
    /// HTTP method used for the request.
    public let method: String
    /// Absolute string of the requested URL.
    public let url: String
    /// HTTP status code returned by the server.
    public let statusCode: Int
    /// Request headers at the time of the call.
    public let requestHeaders: [String: String]?
    /// Response headers returned by the server.
    public let responseHeaders: [String: String]?
    /// Optional body sent with the request.
    public let requestBody: String?
    /// Optional body returned in the response.
    public let responseBody: String?

    public init(
        id: UUID = UUID(),
        date: Date = Date(),
        method: String,
        url: String,
        statusCode: Int,
        requestHeaders: [String: String]?,
        responseHeaders: [String: String]?,
        requestBody: String?,
        responseBody: String?
    ) {
        self.id = id
        self.date = date
        self.method = method
        self.url = url
        self.statusCode = statusCode
        self.requestHeaders = requestHeaders
        self.responseHeaders = responseHeaders
        self.requestBody = requestBody
        self.responseBody = responseBody
    }
}
