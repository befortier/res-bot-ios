//
//  BulkNotificationFlowView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import DesignSystem
import SwiftUI
import Venues
import Websockets

/// Container for the full bulk notification creation flow.
public struct BulkNotificationFlowView: View {
  @StateObject private var viewModel: BulkNotificationFlowViewModel
  @State private var confirmationKind: BulkNotificationConfirmationView.Kind?

  @Environment(\.websocketClient) private var websocketClient

  /// Creates the bulk notification flow view.
  /// - Parameter viewModel: The view model responsible for submission logic.
  public init(viewModel: BulkNotificationFlowViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }

  public var body: some View {
    Group {
      switch viewModel.state.step {
      case .selectTime:
        timeAndPartySizeView
      case .selectVenues:
        bulkNotificationVenueSelectionView
      case .submitted:
        submissionResultsView
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
      dateInterval: $viewModel.state.dateInterval,
      partySizeRange: $viewModel.state.partySizeRange
    ) {
      viewModel.state.step = .selectVenues
    }
  }

  private var bulkNotificationVenueSelectionView: some View {
    BulkNotificationVenueSelectionView(
      allVenues: viewModel.allVenues,
      selectedVenueIDs: $viewModel.state.selectedVenueIDs,
      dateInterval: viewModel.state.dateInterval,
      partySizeRange: viewModel.state.partySizeRange,
    ) {
      Task {
        do {
          try await viewModel.submit(using: websocketClient)
        } catch {
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
      viewModel.state.step = .selectTime
    } label: {
      Image(systemName: "chevron.left")
        .font(.design(.button).bold())
        .foregroundColor(.textPrimary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private var submissionResultsView: some View {
    SubmissionResultView(
      results: viewModel.results,
      expectedCount: viewModel.expectedCount,
      isLoading: viewModel.isReceivingResults
    ) {
      viewModel.reset()
    }
  }

}
