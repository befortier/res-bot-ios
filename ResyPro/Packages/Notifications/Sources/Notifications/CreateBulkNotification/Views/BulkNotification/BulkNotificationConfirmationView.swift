import DesignSystem
import SwiftUI

/// Sheet confirming a bulk notification attempt.
public struct BulkNotificationConfirmationView: View {
  /// Visual representation to display.
  public enum Kind: Identifiable, Sendable {
    /// Confirmation that scheduling succeeded.
    case success
    /// Notification scheduling failed.
    case error

    public var id: Int {
      switch self {
      case .success: return 0
      case .error: return 1
      }
    }
  }

  let kind: Kind
  var onDismiss: () -> Void

  /// Creates the confirmation view.
  /// - Parameters:
  ///   - kind: Indicates if the submission succeeded or failed.
  ///   - onDismiss: Called when the sheet should be dismissed.
  public init(kind: Kind, onDismiss: @escaping () -> Void) {
    self.kind = kind
    self.onDismiss = onDismiss
  }

  public var body: some View {
    VStack(spacing: 24) {
      Image(systemName: iconName)
        .font(.system(size: 48))
        .foregroundColor(iconColor)

      Text(message)
        .font(.design(.title))

      Button("OK") {
        onDismiss()
      }
      .buttonStyle(PrimaryButtonStyle())
    }
    .padding()
  }

  private var iconName: String {
    switch kind {
    case .success: return "bell.fill"
    case .error: return "exclamationmark.triangle.fill"
    }
  }

  private var iconColor: Color {
    switch kind {
    case .success: return .accentColor
    case .error: return .red
    }
  }

  private var message: String {
    switch kind {
    case .success: return "We're on it"
    case .error: return "Oops, try again later"
    }
  }
}
