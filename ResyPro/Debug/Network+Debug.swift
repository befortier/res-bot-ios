//
//  Network+Debug.swift
//  ResyPro
//
//  Created by Ben Fortier on 5/17/25.
//

import Network
import Foundation
import Authentication


enum BearerNetworkServiceComposer {
    static func make(
        configuration: HeaderConfiguration,
        tokenStore: TokenStore
    ) -> any NetworkService {
        NetworkServiceLive(
            client: BearerHTTPClient(
                configuration: configuration,
                session: NetworkClientComposer.make(),
                tokenRefresher: AuthenticationRepositoryLive(
                    networkService: BasicNetworkServiceComposer.make(),
                    tokenStore: tokenStore
                ),
            ),
            jsonDecoder: JSONDecoder()
        )
    }
}

enum BasicNetworkServiceComposer {
    static func make() -> any NetworkService {
        return NetworkServiceLive(
            client: NetworkClientComposer.make()
        )
    }
}

#if DEBUG
import DebugTools

enum NetworkClientComposer {
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
