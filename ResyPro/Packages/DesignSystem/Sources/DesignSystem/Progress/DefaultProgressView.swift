//
//  DefaultProgressView.swift
//  DesignSystem
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

/// A component in the shared design system.
public struct DefaultProgressView: View {
  public init() {}
  public var body: some View {
    ProgressView()
      .controlSize(.large)
      .padding()
      .background(.black.opacity(0.4))
      .clipShape(RoundedRectangle(cornerRadius: 4.0))
  }
}

#Preview {
  DefaultProgressView()
    .padding()
    .previewLayout(.sizeThatFits)
}
