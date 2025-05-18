import SwiftUI

#if DEBUG
  import DebugTools

  private struct DebugMenuObserver: ViewModifier {
    @State private var showDebugMenu = false

    func body(content: Content) -> some View {
      content
        .sheet(isPresented: $showDebugMenu) {
          DebugMenuView()
            .environmentObject(NetworkHistoryStore.shared)
        }
        .overlay(
          ShakeDetector {
            showDebugMenu = true
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
