//
//  AvailableReservationsView.swift
//  ResyPro
//
//  Created by OpenAI on 6/25/24.
//

import DesignSystem
import Reservation
import Notifications
import SwiftUI
import Venues

struct AvailableReservationsView: View {
    @StateObject private var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        Group {
            switch viewModel.state.step {
            case .selectTime:
                TimeAndPartySizeView(
                    dateInterval: $viewModel.state.dateInterval,
                    partySizeRange: $viewModel.state.partySizeRange
                ) {
                    viewModel.state.step = .selectVenues
                }
            case .selectVenues:
                BulkNotificationVenueSelectionView(
                    allVenues: viewModel.allVenues,
                    selectedVenueIDs: $viewModel.state.selectedVenueIDs,
                    dateInterval: viewModel.state.dateInterval,
                    partySizeRange: viewModel.state.partySizeRange
                ) {
                    Task { await viewModel.submit() }
                }
                .safeAreaInset(edge: .top) {
                    Button {
                        viewModel.state.step = .selectTime
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.design(.button).bold())
                            .foregroundColor(.textPrimary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
                }
            }
        }
        .background(Color.backgroundPrimary)
    }
}
