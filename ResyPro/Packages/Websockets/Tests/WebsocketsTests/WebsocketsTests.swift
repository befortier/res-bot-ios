import XCTest
@testable import Websockets

final class WebsocketsTests: XCTestCase {
    struct Payload: Codable, Equatable {
        let message: String
    }

    struct Wrapper<T: Codable>: Codable {
        let name: String
        let data: T
    }

    func testObserveEventYieldsDecodedPayload() async throws {
        let client = WebsocketClient()
        let stream = await client.observeEvent(named: "greeting", as: Payload.self)

        let payload = Payload(message: "hello")
        let wrapper = Wrapper(name: "greeting", data: payload)
        let data = try JSONEncoder().encode(wrapper)

        await client.handle(result: .success(.data(data)))

        let expectation = expectation(description: "receive event")
        Task {
            for await value in stream {
                XCTAssertEqual(value, payload)
                expectation.fulfill()
                break
            }
        }
        await fulfillment(of: [expectation], timeout: 1)
    }
}
