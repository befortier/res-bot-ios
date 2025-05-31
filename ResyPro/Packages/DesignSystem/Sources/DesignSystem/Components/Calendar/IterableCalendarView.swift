//
//  IterableCalendarView.swift
//  DesignSystem
//
//  Created by Ben Fortier on 5/31/25.
//

public import SwiftUI

public struct IterableCalendarView: View {

    @Binding var selectedDate: Date
    let mode: CalendarGridView.Mode
    let notifications: Set<Date>

    public init(
        selectedDate: Binding<Date>,
        mode: CalendarGridView.Mode,
        notifications: Set<Date>
    ) {
        self._selectedDate = selectedDate
        self.mode = mode
        self.notifications = notifications
    }

    public var body: some View {
        HStack(spacing: 8) {
            Button {
                updateSelectedDate(by: -1)
            } label: {
                Image(systemName: "chevron.left")
            }
            .frame(width: 16)

            CalendarGridView(
                mode: mode,
                notifications: notifications,
                selectedDate: $selectedDate
            )
            .frame(maxWidth: .infinity)

            Button {
                updateSelectedDate(by: 1)
            } label: {
                Image(systemName: "chevron.right")
            }
        }
        .buttonStyle(.borderless)
    }

    private func updateSelectedDate(by offset: Int) {
        let calendar = Calendar.current
        let component: Calendar.Component = mode == .month ? .month : .weekOfYear
        selectedDate = calendar.date(byAdding: component, value: offset, to: selectedDate) ?? selectedDate
    }
}

#if DEBUG
#Preview("Month") {
    IterableCalendarView(
        selectedDate: .constant(.now),
        mode: .month,
        notifications: [.now, .now.addingTimeInterval(60 * 60 * 24)]
    )
    .frame(maxWidth: .infinity)
}

#Preview("Week") {
    IterableCalendarPreview(selectedDate: .now)
}


struct IterableCalendarPreview: View {
    @State var selectedDate: Date
    
    var body: some View {
        IterableCalendarView(
            selectedDate: $selectedDate,
            mode: .week,
            notifications: [.now, .now.addingTimeInterval(60 * 60 * 24)]
        )
        .frame(maxWidth: .infinity)
    }
}
#endif
