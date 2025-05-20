//
//  NotificationCard.swift
//  Notifications
//
//  Created by Ben Fortier on 5/18/25.
//

import DesignSystem
import SwiftUI
import Venues

/// Displays information about a notification request.
public struct NotificationCard: View {
    /// Visual style for the card.
    @Environment(\.notificationStyle) private var style: NotificationStyle

    /// Details of the request the notification represents.
    public let request: NotificationTicket
    /// Optional venue associated with the request.
    public let venue: Venue?
    /// Invoked when the delete button is tapped.
    private let onDelete: () -> Void

    /// Creates a notification card.
    public init(
        request: NotificationTicket,
        venue: Venue?,
        onDelete: @escaping () -> Void = {}
    ) {
        self.request = request
        self.venue = venue
        self.onDelete = onDelete
    }


    public var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(venue?.name ?? "Venue \(request.venueID)")
                    .font(.design(.headline))

                Text("Party size \(request.partySize)")
                    .font(.design(.subheadline))

                if let intervalString = DateIntervalFormatter.short.string(from: request.interval) {
                    Text(intervalString)
                        .font(.design(.footnote))
                        .foregroundStyle(Color.textSecondary)
                }
            }

            Spacer()

            if style == .default {
                Button(action: onDelete) {
                    Image(systemName: "trash")
                }
                .buttonStyle(.borderless)
            }
        }
        .padding()
        .cardStyle()
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: 1)
        )
        .overlay(alignment: .topTrailing) {
            Group {
                switch style {
                case .success:
                    overlayImage(
                        systemName: "checkmark.circle.fill",
                        foregroundStyle: .success
                    )
                case .fail:
                    overlayImage(
                        systemName: "xmark.octagon.fill",
                        foregroundStyle: .error
                    )
                case .default:
                    EmptyView()
                }
            }
            .padding(8)
        }
    }

    private func overlayImage(
        systemName: String,
        foregroundStyle: Color
    ) -> some View {
        Image(systemName: systemName)
            .resizable()
            .scaledToFit()
            .foregroundStyle(foregroundStyle)
            .frame(width: 12, height: 12)
    }

    private var backgroundColor: Color {
        switch style {
        case .success:
            return Color.success.opacity(0.1)
        case .fail:
            return Color.error.opacity(0.1)
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
