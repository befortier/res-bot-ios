//
//  PartySizeRangeSelectorView.swift
//  Venues
//
//  Created by Ben Fortier on 5/11/25.
//

import DesignSystem
import SwiftUI

/// A compact control for selecting a minimum and maximum party size.
public struct PartySizeRangeSelectorView: View {
  @Binding var partySizeRange: ClosedRange<Int>
  private let min: Int
  private let max: Int

  public init(
    partySizeRange: Binding<ClosedRange<Int>>,
    rangeBounds: ClosedRange<Int> = 1...20
  ) {
    self._partySizeRange = partySizeRange
    self.min = rangeBounds.lowerBound
    self.max = rangeBounds.upperBound
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("Party Size")
        .font(.design(.headline))
        .foregroundColor(.textPrimary)

      HStack(spacing: 16) {
        Stepper(
          "Min: \(partySizeRange.lowerBound)", value: lowerBinding,
          in: min...partySizeRange.upperBound)
        Stepper(
          "Max: \(partySizeRange.upperBound)", value: upperBinding,
          in: partySizeRange.lowerBound...max)
      }
    }
  }

  private var lowerBinding: Binding<Int> {
    Binding(
      get: { partySizeRange.lowerBound },
      set: { partySizeRange = $0...partySizeRange.upperBound }
    )
  }

  private var upperBinding: Binding<Int> {
    Binding(
      get: { partySizeRange.upperBound },
      set: { partySizeRange = partySizeRange.lowerBound...$0 }
    )
  }
}

#Preview {
  PartySizeRangeSelectorPreview()
}

private struct PartySizeRangeSelectorPreview: View {
  @State private var partySizeRange: ClosedRange<Int> = 1...10
  var body: some View {
    PartySizeRangeSelectorView(partySizeRange: $partySizeRange, rangeBounds: 1...10)
  }
}
