//
//  AppStateViewModifier.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

private struct AppStateViewModifier: ViewModifier {
    let appState: AppState

    func body(content: Content) -> some View {
        content
            .environment(\.resyConfig, appState.resyConfig)
    }
}

extension View {
    func setAppState(_ appState: AppState) -> some View {
        environment(\.resyConfig, appState.resyConfig)
    }
}

@MainActor
struct AppState {
    let user: User
    let resyConfig: ResyConfig

    init(
        user: User,
        resyConfig: ResyConfig
    ) {
        self.user = user
        self.resyConfig = resyConfig
    }
}

@MainActor
extension AppState {
    static func stub(
        user: User? = nil,
        resyConfig: ResyConfig? = nil
    ) -> AppState {
        AppState(
            user: user ?? .stub,
            resyConfig: resyConfig ?? .stub
        )
    }
}
