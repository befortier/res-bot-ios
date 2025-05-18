import SwiftUI

#if DEBUG
  import DebugTools

  private struct DebugMenuObserver: ViewModifier {
    func body(content: Content) -> some View {
      content
        .overlay(
          ShakeDetector {
            DebugMenuPresenter.shared.present()
          }
          .allowsHitTesting(false)
        )
    }
  }

  extension View {
    /// Adds debug menu support that triggers on device shake in debug builds.
    func observeForDebug() -> some View {
      modifier(DebugMenuObserver())
    }
  }
#else
  extension View {
    /// Stubbed in non-debug builds.
    func observeForDebug() -> some View { self }
  }
#endif
