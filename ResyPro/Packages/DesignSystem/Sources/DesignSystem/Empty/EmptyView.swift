//
//  EmptyView.swift
//  DesignSystem
//
//  Created by Code Assistant on 6/20/24.
//

import SwiftUI

/// Displays a generic empty state with an image, title and action button.
public struct EmptyView: View {
    private let viewState: ViewState
    private let action: @MainActor () async -> Void

    public init(
        viewState: ViewState,
        action: @escaping @MainActor () async -> Void
    ) {
        self.viewState = viewState
        self.action = action
    }

    public var body: some View {
        VStack(spacing: 16) {
            viewState.image
                .font(.system(size: 48))
                .foregroundStyle(Color.textSecondary)
            Text(viewState.title)
                .font(.design(.title3))
                .foregroundStyle(Color.textSecondary)
            Button(viewState.buttonTitle) {
                Task { await action() }
            }
                .buttonStyle(PrimaryButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyView(
        viewState: .init(
            image: Image(systemName: "bell"),
            title: "Empty",
            buttonTitle: "Action"
        ),
        action: {}
    )
}
