//
//  BootstrapUseCaseComposer.swift
//  ResyPro
//
//  Created by Ben Fortier on 5/28/25.
//

import User
import Bootstrap
import Authentication
import Network
import Websockets
import ProjectFoundation
import Foundation

enum BootstrapUseCaseComposer {
    static func make(
        modelContainer: any ModelContainerProtocol,
        websocketClient: any WebsocketClient,
    ) -> any BootstrapUseCase {
        let tokenStore = TokenStoreFile()
        return BootstrapUseCaseLive(
            tokenStore: tokenStore,
            userRepository: { userSession in
                let bearerNetworkService = BearerNetworkServiceComposer.make(
                    userSession: userSession
                )
                let store = UserStoreLive(container: modelContainer)
                return UserRepositoryLive(
                    networkService: bearerNetworkService,
                    userStore: store
                )
            },
            logout: {
                await LogoutUseCaseLive(
                    container: modelContainer,
                    websocketClient: websocketClient,
                    websocketURL: URL.websocketServer
                )()
            }
        )

    }
}
