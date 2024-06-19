//
//  User+Environment.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI

private struct UserEnvironmentKey: EnvironmentKey {
    static let defaultValue = User.stub
}

extension EnvironmentValues {
  var user: User {
    get { self[UserEnvironmentKey.self] }
    set { self[UserEnvironmentKey.self] = newValue }
  }
}
