import SwiftUI

/// Invisible view that triggers an action when the user shakes the device.
public struct ShakeDetector: UIViewRepresentable {
    private let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public func makeUIView(context: Context) -> UIView {
        let view = ShakeView()
        view.action = action
        return view
    }

    public func updateUIView(_ uiView: UIView, context: Context) {}
}

private final class ShakeView: UIView {
    var action: (() -> Void)?

    override var canBecomeFirstResponder: Bool { true }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        becomeFirstResponder()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake { action?() }
    }
}
