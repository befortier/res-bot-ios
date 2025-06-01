//
//  SelectDateView.swift
//  DesignSystem
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

/// A component in the shared design system.
public struct SelectDateView: View {
    @Environment(\.selectDateViewStyleKey) private var selectDateViewStyleKey
    private let spacing: CGFloat = 8

    private let title: String?
    private let displayedComponents: DatePicker<EmptyView>.Components
    @Binding private var selectedDate: Date

    public init(
        title: String?,
        selectedDate: Binding<Date>,
        displayedComponents: DatePicker<EmptyView>.Components = [.hourAndMinute, .date]
    ) {
        self.title = title
        self.displayedComponents = displayedComponents
        self._selectedDate = selectedDate
    }

    public var body: some View {
        switch self.selectDateViewStyleKey {
        case .horizontal:
            HStack(spacing: 8) {
                self.titleView
                self.datePickerView
            }
        case .vertical:
            VStack(spacing: 8) {
                self.titleView
                self.datePickerView
            }
        }
    }

    @ViewBuilder
    private var titleView: some View {
        if let title {
            Text(title)
                .font(.design(.callout))
                .foregroundColor(.secondary)
        }
    }

    private var datePickerView: some View {
        DatePicker(
            "",
            selection: $selectedDate,
            in: .now...,
            displayedComponents: displayedComponents
        )
        .clipped()
        .labelsHidden()
    }
}

#Preview {
    SelectDateView(
        title: "Select Date",
        selectedDate: .constant(.now)
    )
}

private struct SelectDateViewStyleKey: EnvironmentKey {
    static let defaultValue = SelectDateViewStyle.horizontal
}

extension EnvironmentValues {
    public var selectDateViewStyleKey: SelectDateViewStyle {
        get { self[SelectDateViewStyleKey.self] }
        set { self[SelectDateViewStyleKey.self] = newValue }
    }
}

extension View {
    public func setSelectDateViewStyleKey(to newStyle: SelectDateViewStyle) -> some View {
        environment(\.selectDateViewStyleKey, newStyle)
    }
}

public enum SelectDateViewStyle: Sendable, Equatable {
    case horizontal
    case vertical
}
