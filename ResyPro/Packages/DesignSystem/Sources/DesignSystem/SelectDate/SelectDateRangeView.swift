//
//  SelectDateRangeView.swift
//  DesignSystem
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

/// A component in the shared design system.
public struct SelectDateRangeView: View {
    @State private var selectedDay: Date
    @State private var minTime: Date
    @State private var maxTime: Date
    @Binding var selectedDateRange: DateInterval

    public init(selectedDateRange: Binding<DateInterval>) {
        self._selectedDateRange = selectedDateRange
        self.selectedDay = selectedDateRange.wrappedValue.start
        self.minTime = selectedDateRange.wrappedValue.start
        self.maxTime = selectedDateRange.wrappedValue.start
    }

    public var body: some View {
        Group {
            SelectDateView(
                title: "Select day",
                selectedDate: $selectedDay,
                displayedComponents: .date
            )
            .onChange(of: selectedDay) { _, newSelectedDay in
                if let newStart = imposedDate(from: newSelectedDay, onto: selectedDateRange.start) {
                    self.selectedDateRange.start = newStart
                }

                if let newEnd = imposedDate(from: newSelectedDay, onto: selectedDateRange.end) {
                    self.selectedDateRange.end = newEnd
                }
            }

                HStack {
                    Text("Time range:")
                        .font(.design(.callout))
                        .foregroundColor(.secondary)

                    SelectDateView(
                        title: nil,
                        selectedDate: $selectedDateRange.start,
                        displayedComponents: .hourAndMinute
                    )

                    Divider()
                        .frame(height: 32)

                    SelectDateView(
                        title: nil,
                        selectedDate: $selectedDateRange.end,
                        displayedComponents: .hourAndMinute
                    )
            }
        }
        .setSelectDateViewStyleKey(to: .horizontal)
    }

    func imposedDate(
        from sourceDate: Date,
        onto targetDate: Date
    ) -> Date? {
        let calendar = Calendar.current

        // Extract day, month, year components from the source date
        let sourceComponents = calendar.dateComponents([.year, .month, .day], from: sourceDate)

        // Extract hour, minute, second components from the target date
        var targetComponents = calendar.dateComponents([.hour, .minute, .second], from: targetDate)

        // Update target components with the source date's day, month, and year
        targetComponents.year = sourceComponents.year
        targetComponents.month = sourceComponents.month
        targetComponents.day = sourceComponents.day

        // Create a new date with the updated components
        return calendar.date(from: targetComponents)
    }
}
