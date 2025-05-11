//
//  RemoteViewState.swift
//  ProjectFoundation
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

/// A enum defined in the ProjectFoundation module.
public enum RemoteViewState<T: Sendable> {
    case loading
    case failed(any Error)
    case success(T)
}
