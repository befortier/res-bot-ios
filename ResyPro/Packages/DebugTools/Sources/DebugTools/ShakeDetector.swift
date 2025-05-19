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
  private var observers: [NSObjectProtocol] = []

  override var canBecomeFirstResponder: Bool { true }

  override func didMoveToWindow() {
    super.didMoveToWindow()
    becomeFirstResponder()

    let center = NotificationCenter.default
    observers.append(
      center.addObserver(
        forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main
      ) { [weak self] _ in
        self?.becomeFirstResponder()
      }
    )
    observers.append(
      center.addObserver(forName: UIWindow.didBecomeKeyNotification, object: nil, queue: .main) {
        [weak self] _ in
        self?.becomeFirstResponder()
      }
    )
    observers.append(
      center.addObserver(
        forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main
      ) { [weak self] _ in
        self?.becomeFirstResponder()
      }
    )
  }

  override func willMove(toWindow newWindow: UIWindow?) {
    if newWindow == nil {
      observers.forEach(NotificationCenter.default.removeObserver)
      observers.removeAll()
    }
    super.willMove(toWindow: newWindow)
  }

  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    if motion == .motionShake { action?() }
  }
}
