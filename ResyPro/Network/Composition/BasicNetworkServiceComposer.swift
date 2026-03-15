//
//  BasicNetworkServiceComposer.swift
//  ResyPro
//
//  Created by Ben Fortier on 5/30/25.
//

import NetworkKit
import Foundation

enum BasicNetworkServiceComposer {
    static func make() -> any NetworkService {
        return NetworkServiceLive(
            client: HTTPClient(
                session: URLSessionComposer.make(),
                adapters: [],
                policy: BasicRetryPolicy()
            ),
            jsonDecoder: JSONDecoder.mixedDateDecoder()
        )
    }
}
