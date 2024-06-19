//
//  SelectDateRangeView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct SelectDateRangeView: View {
    @Binding var selectedDateRange: DateInterval

    var body: some View {
        HStack {
            SelectDateView(
                title: "Start",
                selectedDate: $selectedDateRange.start
            )

            SelectDateView(
                title: "End",
                selectedDate: $selectedDateRange.end
            )
        }
    }
}

#Preview {
    SelectDateRangeView(
        selectedDateRange: .constant(.init(start: .now, end: .now))
    )
}
