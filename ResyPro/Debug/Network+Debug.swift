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
  static func make(configuration: ResyHeaderConfiguration, refresher: any TokenRefreshing)
    -> any NetworkService
  {
    #if DEBUG
      return RefreshingNetworkService(
        configuration: configuration,
        refresher: refresher,
        session: RecordingNetworkSession(wrapped: URLSession.shared)
      )
    #else
      return RefreshingNetworkService(
        configuration: configuration,
        refresher: refresher
      )
    #endif
  }
}
