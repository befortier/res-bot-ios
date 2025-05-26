import Foundation

extension URLResponse {
    /// Returns true if the HTTP response status code is in the 200–299 range.
    public var isHTTPSuccess: Bool {
        guard let httpResponse = self as? HTTPURLResponse else { return false }
        return (200...299).contains(httpResponse.statusCode)
    }
}
