//
//  RemoteViewState.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

enum RemoteViewState<T: Sendable> {
    case loading
    case failed(any Error)
    case success(T)
}
