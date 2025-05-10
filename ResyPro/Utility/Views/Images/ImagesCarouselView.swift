//
//  ImagesCarouselView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/23/24.
//

import SwiftUI
import NukeUI

struct ImagesCarouselView: View {
    let imageUrls: [URL]
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 0){
            TabView(selection: $currentIndex){ // safe area breaks
                ForEach(0..<imageUrls.count,id: \.self){ imageIndex in
                    LazyImage(
                        url: imageUrls[imageIndex],
                        transaction: .init(animation: .none)
                    ) { state in
                        if let image = state.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else {
                            Color.gray.opacity(0.2)
                        }
                    }
                    .tag(imageIndex)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
        }
        .onReceive(timer){_ in
            withAnimation {
                currentIndex = (currentIndex + 1) % imageUrls.count
            }
        }
    }
}
