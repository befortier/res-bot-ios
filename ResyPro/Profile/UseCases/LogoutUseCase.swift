import Foundation
import SwiftData
import ProjectFoundation
import Websockets
import User
import Venues
import os

protocol LogoutUseCase: Sendable {
	func callAsFunction() async
}

struct LogoutUseCaseLive: LogoutUseCase {
	let container: any ModelContainerProtocol
	let websocketClient: any WebsocketClient
	let websocketURL: URL
	private let logger = Logger(subsystem: "com.resy.pro", category: "LogoutUseCase")

	func callAsFunction() async {
	    await clearPersistentData()
	    await websocketClient.disconnect()
	    await websocketClient.connect(url: websocketURL)
	}

	private func clearPersistentData() async {
	    let context = await container.mainContext
	    do {
	        try deleteAll(User.self, from: context)
	        try deleteAll(ScheduledReservation.self, from: context)
	        try deleteAll(Venue.self, from: context)
	        try context.save()
	    } catch {
	        logger.error("Failed to clear persistent data: \(error, privacy: .public)")
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
