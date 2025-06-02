//
//  IterableCalendarView.swift
//  DesignSystem
//
//  Created by Ben Fortier on 5/31/25.
//

public import SwiftUI

public struct IterableCalendarView: View {

    /// June 2025 format
    private static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        return formatter
    }()

    private static let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()

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
            VStack(alignment: .center, spacing: 8) {
                titleText
                iterationButtonContainerView
            }
            .frame(width: 140)

            CalendarGridView(
                mode: mode,
                notifications: notifications,
                selectedDate: $selectedDate
            )
            .frame(maxWidth: .infinity)
            .clipped()
        }
    }

    private var titleText: some View {
        VStack(spacing: 2) {
            Text(Self.monthFormatter.string(from: selectedDate))
                .font(.design(.title).bold())
                .foregroundStyle(Color.textPrimary)

            Text(Self.yearFormatter.string(from: selectedDate))
                .font(.design(.title3))
                .foregroundStyle(Color.textSecondary)
        }

    }

    private var iterationButtonContainerView: some View {
        HStack(spacing: 4) {
            Button {
                updateSelectedDate(by: -1)
            } label: {
                Image(systemName: "chevron.left")
            }
            .frame(width: 16)

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
    IterableCalendarPreview(
        selectedDate: .now
    )
}

#Preview("Week") {
    IterableCalendarPreview(selectedDate: .now)
}


struct IterableCalendarPreview: View {
    @State var selectedDate: Date

    var body: some View {
        IterableCalendarView(
            selectedDate: $selectedDate,
            mode: .month,
            notifications: [.now, .now.addingTimeInterval(60 * 60 * 24)]
        )
        .frame(maxWidth: .infinity)
    }
}
#endif
