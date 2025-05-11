//
//  CardModifier.swift
//  DesignSystem
//
//  Created by Ben Fortier on 6/19/24.
//


import Foundation
import SwiftUI

/// A component in the shared design system.
public struct CardModifier: ViewModifier {
    public init() {}
    public func body(content: Content) -> some View {
        content
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }
}

extension View {
    public func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
}
