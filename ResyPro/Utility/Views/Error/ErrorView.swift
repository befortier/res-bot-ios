//
//  ErrorView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    let error: any Error

    var body: some View {
        VStack {
            Text("An Error Occurred \(error.localizedDescription)")
        }
        .onAppear {
            print("HERE ERROR ", error )
        }
    }
}
