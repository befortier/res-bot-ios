//
//  ResizableImage.swift
//  DesignSystem
//
//  Created by Ben Fortier on 5/13/25.
//

public import SwiftUI
import NukeUI
import Nuke

/// A LazyImage wrapper that dynamically resizes to fit its layout dimensions.
public struct ResizableImage: View {
    public let url: URL?

    public init(url: URL?) {
        self.url = url
    }

    public var body: some View {
        GeometryReader { geometry in
            LazyImage(url: url) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    Color.gray.opacity(0.2)
                }
            }
            .processors([
                ImageProcessors.Resize(
                    size: geometry.size,
                    contentMode: .aspectFill
                )
            ])
            .priority(.normal)
            .transition(.opacity)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
        }
    }
}
