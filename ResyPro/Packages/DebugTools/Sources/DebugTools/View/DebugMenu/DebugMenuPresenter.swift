import SwiftUI
import UIKit
import ProjectFoundation
import SwiftData

/// Handles presentation of the debug menu over any currently visible context.
@MainActor public final class DebugMenuPresenter {
    /// Shared singleton instance used by the debug tools package.
    public static let shared = DebugMenuPresenter()

    private weak var presentedController: UIViewController?

    private init() {}

    /// Presents the ``DebugMenuView`` modally over the top-most view controller
    /// if it is not already visible.
    public func present(container: ModelContainer) {
        guard presentedController == nil else { return }
        guard let rootController = Self.keyWindow?.rootViewController else { return }

        let view = DebugMenuView()
            .environmentObject(NetworkHistoryStore.shared)
            .environmentObject(WebsocketHistoryStore.shared)
            .setModelContainer(container)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { self.dismiss() }
                }
            }

        let host = UIHostingController(rootView: view)
        host.modalPresentationStyle = .overFullScreen

        var topController = rootController
        while let presented = topController.presentedViewController {
            topController = presented
        }
        topController.present(host, animated: true)
        presentedController = host
    }

    /// Dismisses the currently presented debug menu, if any.
    public func dismiss() {
        presentedController?.dismiss(animated: true)
        presentedController = nil
    }

    private static var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first
    }
}
