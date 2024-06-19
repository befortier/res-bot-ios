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

    @State private var selectedDate = Date()

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            SelectDateView(selectedDate: $selectedDate)


//            .padding(.top, 20)
//
//            // List of times
//            List(times, id: \.self) { time in
//                Text(time)
//            }
//            .listStyle(InsetGroupedListStyle())
//            .frame(maxHeight: .infinity)
//            .padding(.horizontal)
        }
        .background(Color(UIColor.systemGray6))
    }
}

#Preview {
    AvailableReservationsView()
}

struct SelectDateView: View {
    @Binding var selectedDate: Date

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            HStack(spacing: 8) {
                Text("Select a Date")
                    .font(.callout)
                    .foregroundColor(.secondary)

                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.compact)
                .clipped()
                .labelsHidden()
            }
        }
    }
}
