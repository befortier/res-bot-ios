import Foundation
import SwiftData
import ProjectFoundation
import Websockets
import User
import Venues

protocol LogoutUseCase: Sendable {
    func callAsFunction() async
}

struct LogoutUseCaseLive: LogoutUseCase {
    let container: any ModelContainerProtocol
    let websocketClient: any WebsocketClient
    let websocketURL: URL

    func callAsFunction() async {
        await clearPersistentData()
        await websocketClient.disconnect()
        await websocketClient.connect(url: websocketURL)
    }

    private func clearPersistentData() async {
        let context = await container.mainContext
        do {
            try deleteAll(User.self, from: context)
            try deleteAll(SchedueledReservation.self, from: context)
            try deleteAll(Venue.self, from: context)
            try context.save()
        } catch {
            // TODO: add error handling/logging
        }
    }

    private func deleteAll<T: PersistentModel>(_ type: T.Type, from context: ModelContext) throws {
        let descriptor = FetchDescriptor<T>()
        let objects = try context.fetch(descriptor)
        for object in objects {
            context.delete(object)
        }
    }
}
