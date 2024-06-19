//
//  ResyConfig+Environment.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

private struct ResyConfigEnvironmentKey: EnvironmentKey {
    static let defaultValue = ResyConfig.stub
}

extension EnvironmentValues {
  var resyConfig: ResyConfig {
    get { self[ResyConfigEnvironmentKey.self] }
    set { self[ResyConfigEnvironmentKey.self] = newValue }
  }
}
