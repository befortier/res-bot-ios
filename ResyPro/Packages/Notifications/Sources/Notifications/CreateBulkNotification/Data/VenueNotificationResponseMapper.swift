import Venues

/// Maps ``VenueNotificationDTO`` values to domain ``VenueNotification`` objects.
protocol VenueNotificationResponseMapper: Sendable {
    func map(dtos: [VenueNotificationDTO]) -> [VenueNotification]
}

struct VenueNotificationResponseMapperLive: VenueNotificationResponseMapper {
    private let venueMapper: any VenueMapper

    init(venueMapper: any VenueMapper = VenueMapperLive()) {
        self.venueMapper = venueMapper
    }

    func map(dtos: [VenueNotificationDTO]) -> [VenueNotification] {
        dtos.map { dto in
            VenueNotification(
                venue: venueMapper.map(dto: dto.venue),
                notifications: dto.notifications
            )
        }
    }
}
