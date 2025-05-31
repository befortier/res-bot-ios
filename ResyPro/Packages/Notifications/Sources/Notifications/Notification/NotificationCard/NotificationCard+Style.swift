//
//  NotificationCard+Style.swift
//  Notifications
//
//  Created by Ben Fortier on 5/31/25.
//

import SwiftUI

/// Styles views according to a notification outcome.
public enum NotificationCardStyle {
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

struct NotificationCardStyleModifier: ViewModifier {
    @Environment(\.notificationCardStyle) private var style: NotificationCardStyle

    func body(content: Content) -> some View {
        content
            .padding(8)
            .cardStyle()
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private var backgroundColor: Color {
        switch style {
        case .success:
            return Color.success.opacity(0.2)
        case .fail:
            return Color.error.opacity(1)
        case .default:
            return Color.white
        }
    }

    private var borderColor: Color {
        switch style {
        case .success:
            return Color.success
        case .fail:
            return Color.error
        case .default:
            return .clear
        }
    }
}

extension View {
    /// Applies consistent card styling based on the current `NotificationCardStyle` environment value.
    func notificationCardStyling() -> some View {
        modifier(NotificationCardStyleModifier())
    }

    /// Applies a color style for notification feedback.
    public func NotificationCardStyle(_ style: NotificationCardStyle) -> some View {
        environment(\.notificationCardStyle, style)
    }
}

extension EnvironmentValues {
    @Entry public var notificationCardStyle: NotificationCardStyle = .default
}
