import XCTest
import SwiftUI
@testable import Venues

final class TextInitTests: XCTestCase {
	func testPartySizeInitializerRendersIcon() {
		let text = Text(partySize: 2)
		let expected = Text("2 ") + Text(Image(systemName: "person"))
		XCTAssertEqual(String(describing: text), String(describing: expected))
	}
}
