//
//  DayCell.swift
//  DesignSystem
//
//  Created by Ben Fortier on 5/31/25.
//

import SwiftUI
extension CalendarGridView {
    struct DayCell: View {
        let date: Date
        let isSelected: Bool
        let hasNotification: Bool

        var body: some View {
            let calendar = Calendar.current
            let dayNumber = calendar.component(.day, from: date)

            Text("\(dayNumber)")
                .frame(maxWidth: .infinity)
                .padding(4)
                .background(isSelected ? Color.accentColor.opacity(0.2) : Color.clear)
                .overlay(alignment: .bottomTrailing) {
                    if hasNotification {
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 6, height: 6)
                    }
                }
        }
    }
}
