//
//  SearchBarView.swift
//  DesignSystem
//
//  Created by Ben Fortier on 5/13/25.
//

import SwiftUI

/// A search bar with a leading magnifying glass icon.

public struct SearchBarView: View {
  @Binding var text: String

  public init(text: Binding<String>) {
    self._text = text
  }

  public var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .foregroundStyle(Color.textPrimary)
      TextField("Search venues", text: $text)
        .textFieldStyle(.plain)
        .disableAutocorrection(true)
        .foregroundStyle(Color.textPrimary)

    }
    .padding(10)
    .background(Color.white)
    .cornerRadius(10)
  }
}

#Preview {
  SearchBarView(text: .constant(""))
    .padding()
    .previewLayout(.sizeThatFits)
}
