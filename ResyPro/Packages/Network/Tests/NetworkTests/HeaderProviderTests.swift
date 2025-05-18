import Testing

@testable import Network

@Suite("HeaderProvider")
struct HeaderProviderTests {
  @Test(arguments: [
    (nil, false),
    ("token123", true),
  ])
  func testCommonHeaders(_ token: String?, _ expectsAuth: Bool) {
    let headers = HeaderProvider.commonHeaders(authToken: token)
    #expect(headers["x-origin"] == "https://resy.com")
    #expect((headers["x-resy-auth-token"] != nil) == expectsAuth)
  }
}
