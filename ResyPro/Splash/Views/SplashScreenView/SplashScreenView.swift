//
//  SplashScreenView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import SwiftData
import User

struct SplashScreenView: View {
    @Environment(\.modelContext) var modelContext

    var body: some View {
        Button("Sign in") {
            modelContext.insert(User.stub)
            modelContext.insert(ResyConfig.stub)
        }
    }
}
