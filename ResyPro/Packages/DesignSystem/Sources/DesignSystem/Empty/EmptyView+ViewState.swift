//
//  EmptyView+ViewState.swift
//  DesignSystem
//
//  Created by Code Assistant on 6/20/24.
//

import SwiftUI

extension EmptyView {
    /// Immutable data needed to render ``EmptyView``.
    public struct ViewState: Equatable, Sendable {
        public let image: Image
        public let title: String
        public let buttonTitle: String

        public init(
            image: Image,
            title: String,
            buttonTitle: String
        ) {
            self.image = image
            self.title = title
            self.buttonTitle = buttonTitle
        }
    }
}
