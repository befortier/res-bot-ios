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
                     Text(slot.time, format: .dateTime)
                         .background(.red)
                         .padding()
                         .cornerRadius(4)
                         .shadow(color: Color.primary.opacity(0.3), radius: 1)

                 }
             }
         }
    }
}
