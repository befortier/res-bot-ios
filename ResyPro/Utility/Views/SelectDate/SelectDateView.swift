//
//  SelectDateView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct SelectDateView: View {
    let title: String
    @Binding var selectedDate: Date

    var body: some View {
        HStack(spacing: 8) {
            Text(self.title)
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

#Preview {
    SelectDateView(
        title: "Select Date",
        selectedDate: .constant(.now)
    )
}
