import XCTest
@testable import DesignSystem

final class FlowLayoutTests: XCTestCase {
    func testLayoutWrapsSubviews() {
        let layout = FlowLayout(spacing: 0, alignment: .leading)
        let width: CGFloat = 100
        let subviewsSizes: [CGSize] = [
            CGSize(width: 60, height: 10),
            CGSize(width: 60, height: 10)
        ]

        let size = layout.sizeThatFits(
            proposal: ProposedViewSize(width: width, height: 100),
            subviews: subviewsSizes.map { size in DummyLayoutSubview(size: size) },
            cache: &()
        )

        XCTAssertTrue(size.height > subviewsSizes[0].height)
    }
}

private struct DummyLayoutSubview: LayoutSubview {
    let size: CGSize
    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize { size }
    func place(at position: CGPoint, proposal: ProposedViewSize) {}
}
