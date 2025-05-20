import DesignSystem
import SwiftUI
import Venues

/// Displays a venue and its notification tickets inside an expandable card.
public struct VenueNotificationCard: View {
	@Binding private var isExpanded: Bool
	private let venueNotification: VenueNotification
	private let venue: Venue?
	private let onDeleteTicket: (NotificationTicket) -> Void
	private let onDeleteVenue: () -> Void

	public init(
		venueNotification: VenueNotification,
		venue: Venue?,
		isExpanded: Binding<Bool>,
		onDeleteTicket: @escaping (NotificationTicket) -> Void = { _ in },
		onDeleteVenue: @escaping () -> Void = {}
	) {
		self.venueNotification = venueNotification
		self.venue = venue
		self._isExpanded = isExpanded
		self.onDeleteTicket = onDeleteTicket
		self.onDeleteVenue = onDeleteVenue
	}

	public var body: some View {
		DisclosureGroup(isExpanded: $isExpanded) {
                        ForEach(venueNotification.notifications, id: \ .self) { ticket in
                                NotificationCard(
                                        viewState: .init(request: ticket, venue: venue),
                                        onDelete: { onDeleteTicket(ticket) }
                                )
                        }
		} label: {
			HStack {
				HorizontalVenueCard(
					model: HorizontalVenueCardModel(venue: venue!)
				)
				Spacer()
				Button(action: onDeleteVenue) {
					Image(systemName: "trash")
						.foregroundColor(.error)
				}
				.buttonStyle(.borderless)
			}
		}
	}
}
