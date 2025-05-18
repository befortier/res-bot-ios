import Foundation
import Testing

@testable import Network

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

struct ServiceEndpoint: GetEndpoint, Sendable {
  let fixturesPath: String?
  let baseURL: BaseURL
  let path: String
  let queryParameters: [String: String]?
  let headers: [String: String]?

  init(
    fixturesPath: String? = nil,
    baseURL: BaseURL = .resy,
    path: String = "/venues",
    queryParameters: [String: String]? = nil,
    headers: [String: String]? = nil
  ) {
    self.fixturesPath = fixturesPath
    self.baseURL = baseURL
    self.path = path
    self.queryParameters = queryParameters
    self.headers = headers
  }
}

struct FakeSession: NetworkSession, Sendable {
  let data: Data
  func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (
    Data, URLResponse
  ) {
    (
      data,
      HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        as URLResponse
    )
  }
}

private struct Venue: Decodable {
  let venueID: Int
  let name: String
}

@Suite("NetworkService")
struct NetworkServiceTests {
  @Test func testFetchFromFixture() async throws {
    let endpoint = ServiceEndpoint(fixturesPath: "venues_fixture")
    let service = NetworkServiceLive()
    let venues: [Venue] = try await service.fetch(from: endpoint)
    #expect(venues.first?.name == "Bungalow")
  }

  @Test func testFetchFromNetwork() async throws {
    let json = "[\"dummy\"]".data(using: .utf8)!
    let session = FakeSession(data: json)
    let endpoint = ServiceEndpoint()
    let service = NetworkServiceLive(client: session)
    let values: [String] = try await service.fetch(from: endpoint)
    #expect(values == ["dummy"])
  }

  @Test func testDecodingError() async {
    let endpoint = ServiceEndpoint()
    let session = FakeSession(data: Data("not json".utf8))
    let service = NetworkServiceLive(client: session)
    do {
      let _: [Venue] = try await service.fetch(from: endpoint)
      #expect(false, "should throw")
    } catch {
      #expect(error is NetworkError)
    }
  }
}
