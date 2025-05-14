//
//  AvailableReservationSlotView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import DesignSystem

struct AvailableReservationSlotView: View {
    let slot: AvailableReservation

    var body: some View {
        Text(slot.time, style: .time)
            .font(.design(.headline))
            .padding()
            .background(.blue.opacity(0.8))
            .cornerRadius(4)
            .shadow(color: Color.primary.opacity(0.3), radius: 1)
    }
}
