import Testing

@testable import Network

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

struct InterpreterEndpoint: GetEndpoint, Sendable {
  let baseURL: BaseURL
  let path: String
  let queryParameters: [String: String]?
  let headers: [String: String]?
  let fixturesPath: String? = nil

  init(
    baseURL: BaseURL,
    path: String,
    queryParameters: [String: String]? = nil,
    headers: [String: String]? = nil
  ) {
    self.baseURL = baseURL
    self.path = path
    self.queryParameters = queryParameters
    self.headers = headers
  }
}

@Suite("EndpointInterpreter")
struct EndpointInterpreterTests {
  @Test(arguments: [
    (
      InterpreterEndpoint(
        baseURL: .resy, path: "/foo", queryParameters: ["a": "1"], headers: ["h": "v"]),
      "https://api.resy.com/foo?a=1",
      "v"
    ),
    (
      InterpreterEndpoint(baseURL: .backend, path: "/bar", queryParameters: nil, headers: nil),
      "https://backend.example.com/bar",
      nil
    ),
  ])
  func testInterpret(
    _ endpoint: InterpreterEndpoint, _ expectedURL: String, _ expectedHeader: String?
  ) {
    let request = EndpointInterpreter.interpret(endpoint: endpoint)
    #expect(request?.url?.absoluteString == expectedURL)
    if let expectedHeader {
      #expect(request?.allHTTPHeaderFields?["h"] == expectedHeader)
    } else {
      #expect(request?.allHTTPHeaderFields == nil)
    }
  }
}
