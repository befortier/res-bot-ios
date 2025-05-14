//
//  FilterChip.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI

/// A pill-style chip used to toggle filtering options.
public struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    public init(title: String, isSelected: Bool, onTap: @escaping () -> Void) {
        self.title = title
        self.isSelected = isSelected
        self.onTap = onTap
    }

    public var body: some View {
        Text(title)
            .font(.design(.subheadline))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.accentColor : Color.gray.opacity(0.2))
            )
            .foregroundColor(isSelected ? .white : .primary)
            .onTapGesture(perform: onTap)
    }
}
