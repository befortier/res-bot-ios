//
//  HorizontalVenueCard.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import DesignSystem
import NukeUI
import SwiftUI

/// A horizontally styled card for displaying a venue.
public struct HorizontalVenueCard: View {

  // MARK: - Properties

  private let imageAspectRatio: CGFloat = 1.0
  private let viewState: ViewState

  public init(viewState: ViewState) {
    self.viewState = viewState
  }

  // MARK: - Body

  public var body: some View {
    GeometryReader { geometry in
      HStack(spacing: 12) {
        venueImage
          .frame(width: geometry.size.width / 2.8)
          .clipped()

        VStack(alignment: .leading, spacing: 4) {
          nameText
          locationText
          cuisineText
        }
        .multilineTextAlignment(.leading)
        .padding(4)
      }
    }
    .aspectRatio(24 / 9, contentMode: .fill)
    .cardStyle()
  }

  // MARK: Text

  private var nameText: some View {
    Text(viewState.name)
      .font(.design(.headline))
      .foregroundStyle(Color.textPrimary)
  }

  private var locationText: some View {
    Text(
      neighborhood: viewState.neighborhood,
      city: viewState.locationName
    )
    .font(.design(.subheadline))
    .foregroundStyle(Color.textSecondary)
  }

  private var cuisineText: some View {
    Text(
      cuisineType: viewState.cuisineType,
      priceRange: viewState.priceRange
    )
    .font(.design(.caption))
    .foregroundStyle(Color.textSecondary)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  // MARK: - Image

  @MainActor
  private var venueImage: some View {
    LazyImage(url: viewState.imageURL) { state in
      if let image = state.image {
        image
          .resizable()
          .scaledToFill()
      } else {
        Color.gray.opacity(0.2)
      }
    }
  }
}

#Preview {
  HorizontalVenueCard(
    viewState: HorizontalVenueCard.ViewState(
      id: 1,
      imageURL: URL(
        string:
          "https://cdn.vox-cdn.com/thumbor/2lEqOWelF_xNUE_Qi-pXd0k7jUg=/1400x1050/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/24036251/Laser_Wolf_23.jpg"
      )!,
      name: "Laser Wolf",
      cuisineType: "Mediterranian",
      priceRange: 3,
      neighborhood: "Chelsea",
      locationName: "New York"
    )
  )
  .padding()
}
