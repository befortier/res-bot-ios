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

private struct NotificationModifier: ViewModifier {
  let style: NotificationStyle
  func body(content: Content) -> some View {
    if let color = style.color {
      content.foregroundColor(color)
    } else {
      content
    }
  }
}

extension View {
  /// Applies a color style for notification feedback.
  public func notificationStyle(_ style: NotificationStyle) -> some View {
    modifier(NotificationModifier(style: style))
  }
}
