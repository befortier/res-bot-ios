//
//  SchedueleReservationHomeView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct SchedueleReservationHomeView: View {
    var body: some View {
        VStack {
            SchedeuledReservationsCarouselView()
            Spacer()
            NavigationLink(destination: SchedueleReservationFormView()) {
                Text("Scheduele New Reservation")
            }
            .navigationTitle("Reserve your reservation")
            Spacer()
        }
    }
}
