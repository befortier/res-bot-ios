//
//  ButtonStyles.swift
//  DesignSystem
//
//  Created by Ben Fortier on 6/19/24.
//

import SwiftUI

/// A component in the shared design system.
public struct PrimaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled: Bool
  public init() {}

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.design(.button))
      .foregroundColor(.primaryButtonText)
      .frame(minHeight: 44)
      .padding(.horizontal, 12)
      .background(
        isEnabled
          ? (configuration.isPressed ? Color.primaryButtonPressed : Color.primaryButtonEnabled)
          : Color.primaryButtonDisabled
      )
      .cornerRadius(10)
      .opacity(isEnabled ? 1.0 : 0.6)
  }
}

public struct SecondaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled: Bool

  public init() {}

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.design(.button))
      .foregroundColor(isEnabled ? Color.secondaryButtonText : Color.secondaryButtonDisabled)
      .padding(8)
      .background(Color.clear)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(
            isEnabled
              ? (configuration.isPressed
                ? Color.secondaryButtonPressed : Color.secondaryButtonBorder)
              : Color.secondaryButtonDisabled,
            lineWidth: 1
          )
      )
      .opacity(configuration.isPressed ? 0.9 : 1.0)
  }
}

public struct TertiaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled: Bool
  public init() {}

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.design(.button))
      .foregroundColor(
        isEnabled
          ? (configuration.isPressed ? Color.tertiaryButtonPressed : Color.tertiaryButtonText)
          : Color.tertiaryButtonDisabled
      )
      .padding(.vertical, 8)
      .padding(.horizontal, 4)
      .opacity(configuration.isPressed ? 0.9 : 1.0)
  }
}

#Preview {
  VStack {
    Button("Primary Button") {}
      .buttonStyle(PrimaryButtonStyle())

    Button("Secondary Button") {}
      .buttonStyle(SecondaryButtonStyle())

    Button("Tertiary Button") {}
      .buttonStyle(TertiaryButtonStyle())
  }
}
