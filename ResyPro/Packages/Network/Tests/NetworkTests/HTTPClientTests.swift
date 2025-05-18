import Foundation
import Testing

@testable import Network

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

private actor CaptureSession: NetworkSession {
    private(set) var receivedRequest: URLRequest?

    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        receivedRequest = request
        return (
            Data(),
            HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)! as URLResponse
        )
    }
}

@Suite("HTTPClient")
struct HTTPClientTests {
    @Test func testBearerAddsHeaders() async throws {
        let session = CaptureSession()
        let config = ResyHeaderConfiguration(userID: "x", bearerToken: "abc", resyAuthToken: "xyz")
        let client = BearerHTTPClient(configuration: config, session: session)
        let request = URLRequest(url: URL(string: "https://example.com")!)
        _ = try await client.data(for: request, delegate: nil)
        let captured = await session.receivedRequest
        #expect(captured?.value(forHTTPHeaderField: "Authorization") == "Bearer abc")
        #expect(captured?.value(forHTTPHeaderField: "x-resy-auth-token") == "xyz")
        #expect(captured?.value(forHTTPHeaderField: "x-resy-universal-auth") == "xyz")
        #expect(captured?.value(forHTTPHeaderField: "user-id") == "x")
    }
}
