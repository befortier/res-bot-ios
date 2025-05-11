//
//  ErrorView.swift
//  DesignSystem
//
//  Created by Ben Fortier on 6/19/24.
//


import Foundation
import SwiftUI

/// A component in the shared design system.
public struct ErrorView: View {
    private let error: any Error

    public init(error: any Error) {
        self.error = error
    }

    public var body: some View {
        VStack {
            Text("An Error Occurred \(error.localizedDescription)")
        }
        .onAppear {
            print("HERE ERROR ", error )
        }
    }
}
