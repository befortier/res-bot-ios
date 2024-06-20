//
//  AvailableReservationsGridView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct AvailableReservationsGridView: View {
    @State var gridLayout: [GridItem] = [ GridItem() ]
    let slots: [AvailableReservation]

    var body: some View {
        ScrollView {
             LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                 ForEach(slots) { slot in
                     AvailableReservationSlotView(slot: slot)
                 }
             }
         }
    }
}
