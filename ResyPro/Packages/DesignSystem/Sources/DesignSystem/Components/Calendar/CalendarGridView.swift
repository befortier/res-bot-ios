//
//  CalendarGridView.swift
//  DesignSystem
//
//  Created by Ben Fortier on 5/31/25.
//
import SwiftUI

public struct CalendarGridView: View {
    private let mode: Mode
    private let notifications: Set<Date>
    @Binding private var selectedDate: Date
    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)


    public init(
        mode: Mode,
        notifications: Set<Date>,
        selectedDate: Binding<Date>
    ) {
        self.mode = mode
        self.notifications = notifications
        self._selectedDate = selectedDate
    }

    public var body: some View {
        let days = computeDays(for: selectedDate, mode: mode)
        LazyVGrid(columns: columns, spacing: 4) {
            ForEach(days, id: \.self.timeIntervalSince1970) { day in
                DayCell(
                    date: day,
                    isSelected: calendar.isDate(day, inSameDayAs: selectedDate),
                    hasNotification: notifications.contains(calendar.startOfDay(for: day))
                )
                .onTapGesture { selectedDate = day }
            }
        }
    }

    private func computeDays(for date: Date, mode: Mode) -> [Date] {
        let calendar = Calendar.current
        switch mode {
        case .month:
            guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date)),
                  let range = calendar.range(of: .day, in: .month, for: startOfMonth) else {
                return []
            }
            return range.compactMap { day -> Date? in
                calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
            }
        case .week:
            guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: date)?.start else {
                return []
            }
            return (0..<7).compactMap { offset in
                calendar.date(byAdding: .day, value: offset, to: startOfWeek)
            }
        }
    }
}


#Preview {
    HStack(spacing: 8) {
        Text("hi")
        CalendarGridView(
            mode: .month,
            notifications: [.now, .now.addingTimeInterval(60 * 60 * 24)],
            selectedDate: .constant(.now)
        )
        .frame(maxWidth: .infinity)

        Text("hi")
    }
    .frame(maxWidth: .infinity)
}
