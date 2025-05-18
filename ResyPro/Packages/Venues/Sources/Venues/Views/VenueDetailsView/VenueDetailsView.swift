//
//  VenueDetailsView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import DesignSystem
import NukeUI
import SwiftUI

/// Screen showing detailed information for a single venue.

public struct VenueDetailsView: View {
  private let viewState: VenueDetailsViewState
  private let actionHandler: ActionHandler

  public init(
    viewState: VenueDetailsViewState,
    actionHandler: @escaping ActionHandler
  ) {
    self.viewState = viewState
    self.actionHandler = actionHandler
  }

  public var body: some View {
    ScrollView {
      VStack(spacing: 16) {
        headerImage
        content
        actionButtons
      }
    }
    .ignoresSafeArea(edges: .top)
    .scrollBounceBehavior(.basedOnSize)
    .background(Color.backgroundPrimary)
  }

  private var headerImage: some View {
    LazyImage(url: viewState.imageURL) { state in
      if let image = state.image {
        image
          .resizable()
          .scaledToFill()
      } else {
        Color.gray.opacity(0.2)
      }
    }
    .frame(maxWidth: .infinity)
    .aspectRatio(16 / 9, contentMode: .fit)
    .clipShape(RoundedRectangle(cornerRadius: 0))
  }

  private var content: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(viewState.name)
        .font(.design(.title)).bold()
        .foregroundStyle(Color.textPrimary)

      Text(
        cuisineType: viewState.cuisineType,
        priceRange: viewState.priceRange
      )
      .font(.design(.subheadline))
      .foregroundStyle(Color.textSecondary)

      Text(neighborhood: viewState.neighborhood, city: viewState.city)
        .font(.design(.subheadline))
        .foregroundStyle(Color.textSecondary)

      if let needToKnow = viewState.needToKnow {
        Text(needToKnow)
          .font(.design(.footnote))
          .foregroundStyle(Color.textSecondary)
          .padding(.top, 8)
      }
    }
    .padding(.horizontal, 16)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private var actionButtons: some View {
    VStack(spacing: 12) {
      Button {
        actionHandler(.notifyMe)
      } label: {
        Text("🔔 Notify Me")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(PrimaryButtonStyle())

      Button {
        actionHandler(.scheduleBot)
      } label: {
        Text("🤖 Schedule Bot")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(SecondaryButtonStyle())

      Button {
        actionHandler(.seeAvailability)
      } label: {
        Text("📆 See Availability")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(SecondaryButtonStyle())
    }
    .padding(.horizontal, 32)
    .padding(.top, 12)
  }

}

#Preview {
  VenueDetailsView(viewState: .init(venue: .laserWolf)) { _ in }
}
