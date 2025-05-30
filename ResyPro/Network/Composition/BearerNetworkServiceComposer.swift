//
//  BearerNetworkServiceComposer.swift
//  ResyPro
//
//  Created by Ben Fortier on 5/30/25.
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
                session: URLSessionComposer.make(),
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
            jsonDecoder: JSONDecoder.mixedDateDecoder()
        )
    }
}
