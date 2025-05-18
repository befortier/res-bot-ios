//
//  BulkNotificationFlowView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import DesignSystem
import SwiftUI
import Venues

/// Container for the full bulk notification creation flow.
public struct BulkNotificationFlowView: View {
  @State private var viewState: ViewState
  @State private var confirmationKind: BulkNotificationConfirmationView.Kind?

  private let viewModel: BulkNotificationFlowViewModel

  /// Creates the bulk notification flow view.
  /// - Parameters:
  ///   - initialState: Optional starting state of the flow.
  ///   - viewModel: The view model responsible for submission logic.
  public init(
    initialState: ViewState? = nil,
    viewModel: BulkNotificationFlowViewModel
  ) {
    let calendar = Calendar.current
    let today = Date()
    let defaultStart =
      calendar.date(
        bySettingHour: 18,
        minute: 30,
        second: 0,
        of: today
      ) ?? today
    let defaultEnd =
      calendar.date(
        bySettingHour: 21,
        minute: 0,
        second: 0,
        of: today
      ) ?? defaultStart.addingTimeInterval(60 * 60 * 2.5)

    let startingState =
      initialState
      ?? ViewState(
        dateInterval: DateInterval(start: defaultStart, end: defaultEnd),
        partySizeRange: 2...4,
        selectedVenueIDs: Set(viewModel.allVenues.map(\.venueID))
      )
    self._viewState = State(initialValue: startingState)
    self.viewModel = viewModel
  }

  public var body: some View {
    Group {
      switch viewState.step {
      case .selectTime:
        timeAndPartySizeView
      case .selectVenues:
        bulkNotificationVenueSelectionView
      case .submitted:
        timeAndPartySizeView
      }
    }
    .background(Color.backgroundPrimary)
    .sheet(item: $confirmationKind) { kind in
      BulkNotificationConfirmationView(kind: kind) {
        confirmationKind = nil
      }
    }
  }

  private var timeAndPartySizeView: some View {
    TimeAndPartySizeView(
      dateInterval: $viewState.dateInterval,
      partySizeRange: $viewState.partySizeRange
    ) {
      viewState.step = .selectVenues
    }
  }

  private var bulkNotificationVenueSelectionView: some View {
    BulkNotificationVenueSelectionView(
      allVenues: viewModel.allVenues,
      selectedVenueIDs: $viewState.selectedVenueIDs,
      dateInterval: viewState.dateInterval,
      partySizeRange: viewState.partySizeRange,
    ) {
      Task {
        do {
          _ = try await viewModel.submit(from: viewState)
          self.viewState.step = .selectTime
          self.confirmationKind = .success
        } catch {
          print("HERE", error)
          self.confirmationKind = .error
        }
      }
    }
    .safeAreaInset(edge: .top) {
      backButton
        .padding(.leading, 12)
    }
  }

  private var backButton: some View {
    Button {
      viewState.step = .selectTime
    } label: {
      Image(systemName: "chevron.left")
        .font(.design(.button).bold())
        .foregroundColor(.textPrimary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
