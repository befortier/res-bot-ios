import Testing

@testable import Network

@Suite("EnvironmentStore")
struct EnvironmentStoreTests {
  @Test func testUpdate() async {
    let store = EnvironmentStore()
    await store.update(.debug)
    let value = await store.environment
    #expect(value == .debug)
  }
}
