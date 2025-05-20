import DesignSystem
import SwiftUI

/// Displays a notification request in compact form.
public struct ShortNotificationCard: View {
	/// Visual style for the card.
	@Environment(\.notificationStyle) private var style: NotificationStyle

	/// Immutable view data.
	private let viewState: NotificationCard.ViewState
	/// Invoked when the delete button is tapped.
	private let onDelete: () -> Void

	/// Creates a short notification card.
	/// - Parameters:
	///   - viewState: Immutable card data.
	///   - onDelete: Invoked when the delete button is tapped.
	public init(
		viewState: NotificationCard.ViewState,
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
		.padding()
		.cardStyle()
		.background(backgroundColor)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay(
			RoundedRectangle(cornerRadius: 12)
				.stroke(borderColor, lineWidth: 1)
		)
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
