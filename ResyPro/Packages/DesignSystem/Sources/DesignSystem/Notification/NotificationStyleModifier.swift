import SwiftUI

/// Styles views according to a notification outcome.
public enum NotificationStyle {
    case success
    case fail
    case `default`

    var color: Color? {
        switch self {
        case .success:
            return .success
        case .fail:
            return .error
        case .default:
            return nil
        }
    }
}

extension EnvironmentValues {
    @Entry public var notificationStyle: NotificationStyle = .default
}

extension View {
    /// Applies a color style for notification feedback.
    public func notificationStyle(_ style: NotificationStyle) -> some View {
        environment(\.notificationStyle, style)
    }
}
