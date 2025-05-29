//
//  Network+Debug.swift
//  ResyPro
//
//  Created by Ben Fortier on 5/17/25.
//

import Network
import Foundation
import Authentication
import User

enum BearerNetworkServiceComposer {
    static func make(
        userSession: UserSession
    ) -> any NetworkService {
        NetworkServiceLive(
            client: BearerHTTPClient(
                configuration: HeaderConfiguration(
                    user: userSession.user,
                    token: { userSession.token.token }
                ),
                session: NetworkClientComposer.make(),
                tokenRefresher: BearerTokenRefresher(
                    authTokenRepository: AuthenticationRepositoryLive(
                        networkService: BasicNetworkServiceComposer.make(),
                        tokenStore: TokenStoreFile()
                    ),
                    userSession: userSession
                )

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

struct BearerTokenRefresher: TokenRefreshing {
    let authTokenRepository: any AuthenticationRepository
    let userSession: UserSession

    public func refreshToken() async throws {
        let tokenPair = try await authTokenRepository.refresh()
        userSession.updateToken(tokenPair)
    }
}

