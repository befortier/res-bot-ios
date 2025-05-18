//
//  FlowLayout.swift
//  DesignSystem
//
//  Created by Ben Fortier on 5/11/25.
//

import SwiftUI

/// A layout that arranges views in a horizontal flow, wrapping onto new lines as needed.
public struct FlowLayout: Layout {
  public var spacing: CGFloat
  public var alignment: HorizontalAlignment

  public init(spacing: CGFloat = 8, alignment: HorizontalAlignment = .leading) {
    self.spacing = spacing
    self.alignment = alignment
  }

  public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ())
    -> CGSize
  {
    var width: CGFloat = 0
    var height: CGFloat = 0
    var currentLineWidth: CGFloat = 0
    var currentLineHeight: CGFloat = 0

    let maxWidth = proposal.width ?? .infinity

    for subview in subviews {
      let size = subview.sizeThatFits(.unspecified)

      if currentLineWidth + size.width > maxWidth {
        height += currentLineHeight + spacing
        currentLineWidth = 0
        currentLineHeight = 0
      }

      currentLineWidth += size.width + spacing
      currentLineHeight = max(currentLineHeight, size.height)
    }

    height += currentLineHeight
    return CGSize(width: maxWidth, height: height)
  }

  public func placeSubviews(
    in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()
  ) {
    var x: CGFloat = 0
    var y: CGFloat = 0
    var lineHeight: CGFloat = 0

    for subview in subviews {
      let size = subview.sizeThatFits(.unspecified)

      if x + size.width > bounds.width {
        x = 0
        y += lineHeight + spacing
        lineHeight = 0
      }

      subview.place(
        at: CGPoint(x: bounds.minX + x, y: bounds.minY + y),
        proposal: ProposedViewSize(size)
      )
      x += size.width + spacing
      lineHeight = max(lineHeight, size.height)
    }
  }
}

#Preview {
  FlowLayout(spacing: 8) {
    ForEach(0..<10) { index in
      Text("Item \(index)")
        .padding(4)
        .background(Color.gray.opacity(0.2))
    }
  }
  .padding()
  .previewLayout(.sizeThatFits)
}
