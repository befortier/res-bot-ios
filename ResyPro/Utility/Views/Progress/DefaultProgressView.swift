//
//  DefaultProgressView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct DefaultProgressView: View {
    var body: some View {
        ProgressView()
            .controlSize(.large)
            .padding()
            .background(.black.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
    }
}
