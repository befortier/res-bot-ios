//
//  AvailableReservationsView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

import SwiftUI

struct AvailableReservationsView: View {
    // Example data for times
    let times = ["09:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "01:00 PM"]

    @StateObject private var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            SelectDateView(
                title: "Select Date",
                selectedDate: $viewModel.selectedDate
            )

            switch self.viewModel.listState {
            case .loading: DefaultProgressView()
            case .success(let slots): AvailableReservationsGridView(slots: slots)
            case .failed(let error): ErrorView(error: error)
            }
        }
        .background(Color(UIColor.systemGray6))
    }
}

#Preview {
    AvailableReservationsView(viewModel: .init())
}
