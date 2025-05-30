//
//  URLSessionComposer.swift
//  ResyPro
//
//  Created by Ben Fortier on 5/30/25.
//

import Network
import Foundation

#if DEBUG
import DebugTools

enum URLSessionComposer {
    static func make() -> any NetworkClient {
        RecordingNetworkClient(
            wrapped: URLSession.shared
        )
    }
}
#else
enum URLSessionComposer {
    static func make() -> any NetworkClient {
        URLSession.shared
    }
}
#endif
