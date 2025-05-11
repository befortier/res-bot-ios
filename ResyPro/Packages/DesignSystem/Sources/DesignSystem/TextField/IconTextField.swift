//
//  IconTextField.swift
//  DesignSystem
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

/// A component in the shared design system.
public struct IconTextField: View {
    var icon: String?
    var placeholder: String
    @Binding var text: String

    public init(icon: String? = nil, placeholder: String, text: Binding<String>) {
        self.icon = icon
        self.placeholder = placeholder
        self._text = text
    }

    public var body: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.gray)
            }
            TextField(placeholder, text: $text)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
        .padding(.horizontal, 10)
    }
}
