//
//  TimeAndPartySizeView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI
import DesignSystem

/// The first step in the bulk notification flow: set date interval and party size.
public struct TimeAndPartySizeView: View {
    @Binding var dateInterval: DateInterval
    @Binding var partySizeRange: ClosedRange<Int>
    var onNext: () -> Void

    public init(
        dateInterval: Binding<DateInterval>,
        partySizeRange: Binding<ClosedRange<Int>>,
        onNext: @escaping () -> Void
    ) {
        self._dateInterval = dateInterval
        self._partySizeRange = partySizeRange
        self.onNext = onNext
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Group {
                    Text("When would you like to eat?")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    SelectDateRangeView(selectedDateRange: $dateInterval)
                        .datePickerStyle(.graphical)
                }

                PartySizeRangeSelectorView(partySizeRange: $partySizeRange)

                Button("Next: Choose Venues") {
                    onNext()
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding()
        }
    }
}

#Preview {
    TimeAndPartySizePreview()
}

fileprivate struct TimeAndPartySizePreview: View {
    @State private var partySizeRange = ClosedRange<Int>(uncheckedBounds: (lower: 1, upper: 10))
    @State private var dateInterval = DateInterval(start: .now, end: .now.advanced(by: 60*60*4))
    var body: some View {
        TimeAndPartySizeView(
            dateInterval: $dateInterval,
            partySizeRange: $partySizeRange) {

            }
    }
}
