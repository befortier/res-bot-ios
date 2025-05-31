import DesignSystem
import SwiftUI

/// Displays a notification request in compact form.
///
/// Used when viewing notifications by venue where there may be loads of them.
public struct ShortNotificationCard: View {
    /// Visual style for the card.
    @Environment(\.notificationCardStyle) private var style: NotificationCardStyle

    /// Immutable view data.
    private let viewState: ViewState
    /// Invoked when the delete button is tapped.
    private let onDelete: () -> Void

    /// Creates a short notification card.
    /// - Parameters:
    ///   - viewState: Immutable card data.
    ///   - onDelete: Invoked when the delete button is tapped.
    public init(
        viewState: ViewState,
        onDelete: @escaping () -> Void = {}
    ) {
        self.viewState = viewState
        self.onDelete = onDelete
    }

    public var body: some View {
        HStack(alignment: .center) {
            descriptionText
            Spacer()
            if style == .default {
                Button(action: onDelete) {
                    Image(systemName: "trash")
                }
                .buttonStyle(.borderless)
            }
        }
        .notificationCardStyling()
    }

    @ViewBuilder private var descriptionText: some View {
        if let intervalString = DateIntervalFormatter.short.string(from: viewState.interval) {
            (
                Text(intervalString)
                + Text(" · ")
                + Text(partySize: viewState.partySize)
            )
            .font(.design(.footnote))
            .foregroundStyle(Color.textSecondary)
        }
    }
}

#Preview {
    ShortNotificationCard(
        viewState: ShortNotificationCard.ViewState(
            venueName: "Laser Wolf",
            venueID: 10,
            partySize: 4,
            interval: .init(start: .now, duration: 60*60*24)
        )
    ) { }
        .padding()
}
