//
//  Network+Debug.swift
//  ResyPro
//
//  Created by Ben Fortier on 5/17/25.
//

import Network
import Foundation
import Authentication

#if DEBUG
import DebugTools

enum BearerNetworkServiceComposer {
    static func make(
        configuration: ResyHeaderConfiguration,
        tokenStore: TokenStore
    ) -> any NetworkService {
      return RefreshingNetworkService(
        configuration: configuration,
        refresher: AuthenticationRepositoryLive(
            networkService: BasicNetworkServiceComposer.make(),
            tokenStore: tokenStore
        ),
        session: RecordingNetworkSession(
            wrapped: URLSession.shared
        )
      )
  }
}

enum BasicNetworkServiceComposer {
    static func make() -> any NetworkService {
        return NetworkServiceLive(
            client: RecordingNetworkSession(
                wrapped: BasicHTTPClient(
                    session: URLSession.shared
                )
            )
        )
    }
}


#else

enum BearerNetworkServiceComposer {
  static func make(configuration: ResyHeaderConfiguration, refresher: any TokenRefreshing) -> any NetworkService {
      return RefreshingNetworkService(
        configuration: configuration,
        refresher: refresher
      )
  }
}

enum BasicNetworkServiceComposer {
    static func make() -> any NetworkService {
        return NetworkServiceLive(
            client: BasicHTTPClient(
                session: URLSession.shared
            )
        )
    }
}

#endif
