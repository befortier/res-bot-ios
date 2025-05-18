//
//  Network+Debug.swift
//  ResyPro
//
//  Created by Ben Fortier on 5/17/25.
//

import Network
#if DEBUG
import DebugTools
#endif

enum BearerNetworkServiceComposer {
    static func make(configuration: ResyHeaderConfiguration) -> any NetworkService {
#if DEBUG
        DebugNetworkServiceLive(
            client: BearerHTTPClient(configuration: configuration)
        )
#else
        NetworkServiceLive(client: BearerHTTPClient(configuration: configuration))
#endif
    }
}
