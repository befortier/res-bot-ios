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
            client: HTTPClient(
                session: NetworkClientComposer.make(),
                adapters: [
                    BearerRequestAdapter(
                        configuration: HeaderConfiguration(
                            userID: userSession.user.id,
                            bearerToken: { userSession.token.token },
                            resyAuthToken: userSession.user.resyAuthToken ?? "should-probably-fix-this"
                        )
                    )
                ],
                policy: BearerRetryPolicy(
                    refresher: TokenRefresher(
                        authTokenRepository: AuthenticationRepositoryLive(
                            networkService: BasicNetworkServiceComposer.make(),
                            tokenStore: TokenStoreFile()
                        ),
                        userSession: userSession
                    ),
                ),
            ),
            jsonDecoder: JSONDecoder()
        )
    }
}

enum BasicNetworkServiceComposer {
    static func make() -> any NetworkService {
        return NetworkServiceLive(
            client: HTTPClient(
                session: NetworkClientComposer.make(),
                adapters: [],
                policy: BasicRetryPolicy()
            ),
            jsonDecoder: JSONDecoder()
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

struct TokenRefresher: TokenRefreshing {
    let authTokenRepository: any AuthenticationRepository
    let userSession: UserSession

    public func refreshToken() async throws {
        let tokenPair = try await authTokenRepository.refresh()
        userSession.updateToken(tokenPair)
    }
}

