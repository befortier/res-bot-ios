//
//  NotificationCard.swift
//  Notifications
//
//  Created by Ben Fortier on 5/18/25.
//

import DesignSystem
import SwiftUI

/// Displays information about a notification request.
public struct NotificationCard: View {
    private let iconSize: CGFloat = 12

    /// Visual style for the card.
    @Environment(\.notificationCardStyle) private var style: NotificationCardStyle

    /// Immutable view data.
    private let viewState: ViewState
    /// Invoked when the delete button is tapped.
    private let onDelete: () -> Void

    /// Creates a notification card.
    public init(
        viewState: ViewState,
        onDelete: @escaping () -> Void = {}
    ) {
        self.viewState = viewState
        self.onDelete = onDelete
    }


    public var body: some View {
        GeometryReader { geo in
            HStack(spacing: 16) {
                textContainer
                    .frame(maxWidth: .infinity, alignment: .leading)
                ResizableImage(url: viewState.venueImageURL)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: geo.size.width * 0.3)
            }
            .notificationCardStyling()
            .overlay(alignment: .topTrailing) {
                overlayTrailingIcon
                    .offset(x: iconSize / 3, y: -iconSize / 3)
                    .frame(width: iconSize, height: iconSize)
            }
        }
        .aspectRatio(32/9, contentMode: .fit)
    }

    private var textContainer: some View {
        VStack(alignment: .leading, spacing: 4) {
            dateText
            venueNameText
            Spacer()
            partySizeText
        }
        .padding(.vertical, 8)
    }

    @ViewBuilder
    private var dateText: some View {
        Text(DateIntervalFormatter.standardString(viewState.interval))
            .font(.design(.footnote))
            .foregroundStyle(Color.textSecondary)
    }

    private var venueNameText: some View {
        Text(viewState.venueName)
            .font(.design(.title3))
            .foregroundStyle(Color.textPrimary)
    }

    private var partySizeText: some View {
        Text(partySizes: viewState.partySizes)
            .font(.design(.footnote))
            .foregroundStyle(Color.textSecondary)
    }

    @ViewBuilder
    private var overlayTrailingIcon: some View {
        switch style {
        case .success:
            overlayImage(
                systemName: "checkmark",
                foregroundStyle: .success
            )
        case .fail:
            overlayImage(
                systemName: "xmark",
                foregroundStyle: .error
            )
        case .default:
            EmptyView()
        }
    }

    private func overlayImage(
        systemName: String,
        foregroundStyle: Color
    ) -> some View {
        Circle()
            .fill(foregroundStyle)
            .overlay {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .padding(3)
                    .bold()
            }
    }

    private var deleteButton: some View {
        Button(action: onDelete) {
            Image(systemName: "trash")
        }
        .buttonStyle(.borderless)
    }
}

// MARK: Preview

#if DEBUG
#Preview {
    VStack(spacing: 8) {
        NotificationCard(
            viewState: NotificationCard.ViewState(
                venueName: "Laser Wolf",
                venueID: 10,
                partySizes: [4],
                interval: .init(start: .now, duration: 60*60*24),
                venueImageURL: .venueImageURL
            )
        ) { }
        NotificationCard(
            viewState: NotificationCard.ViewState(
                venueName: "Laser Wolf",
                venueID: 10,
                partySizes: [4, 5],
                interval: .init(start: .now, duration: 60*60*24),
                venueImageURL: .venueImageURL
            )
        ) { }
            .NotificationCardStyle(.fail)

        NotificationCard(
            viewState: NotificationCard.ViewState(
                venueName: "Laser Wolf",
                venueID: 10,
                partySizes: [4, 5, 3],
                interval: .init(start: .now, duration: 60*60*24),
                venueImageURL: nil
            )
        ) { }
            .NotificationCardStyle(.success)
    }
    .padding(16)
}
#endif
