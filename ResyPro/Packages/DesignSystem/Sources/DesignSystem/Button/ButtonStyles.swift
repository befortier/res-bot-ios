//
//  ButtonStyles.swift
//  DesignSystem
//
//  Created by Ben Fortier on 6/19/24.
//

import SwiftUI

/// A component in the shared design system.
public struct PrimaryButtonStyle: ButtonStyle {
    public init() { }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(Color.buttonPrimary)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

public struct SecondaryButtonStyle: ButtonStyle {
    public init() { }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(Color.white)
            .background(Color.buttonTertiary)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

public struct TertiaryButtonStyle: ButtonStyle {
    public init() { }
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(Color.buttonSecondary)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)

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
