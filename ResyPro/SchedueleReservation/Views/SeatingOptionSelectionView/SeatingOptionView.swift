//
//  SeatingOptionView.swift
//  Venues
//
//  Created by Ben Fortier on 6/19/24.
//

import DesignSystem
import Foundation
import SwiftUI

/// A struct defined in the Venues module.
struct SeatingOptionView: View {
    let option: String
    let isFilled: Bool

    var body: some View {
        Text(option)
            .font(.subheadline)
            .tag(option)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isFilled ? .black.opacity(0.8) : Color.foregroundPrimary)
            .foregroundStyle(isFilled ? .white : .textPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .lineLimit(1)
    }
}
