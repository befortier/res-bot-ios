//
//  URLSessionWebsocketClient.swift
//  Websockets
//
//  Created by OpenAI on 6/19/24.
//

import Foundation

/// A lightweight websocket client built on top of ``URLSessionWebSocketTask``.
public actor URLSessionWebsocketClient: WebsocketClient {
    private let session: URLSession
    private var task: URLSessionWebSocketTask?
    private var handlers: [String: [EventSubscription]] = [:]
    private let decoder: JSONDecoder

    /// Creates a new ``URLSessionWebsocketClient`` using the provided ``URLSession``.
    /// - Parameter session: The session used to create the websocket task.
    public init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }

    /// Opens the websocket connection to the given URL.
    /// - Parameter url: The endpoint of the websocket server.
    public func connect(url: URL) {
        guard task == nil else { return }

        let task = session.webSocketTask(with: url)
        task.resume()
        self.task = task
        listen()
    }

    /// Disconnects from the websocket server.
    public func disconnect() {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
    }

    /// Sends an authentication message with the provided user identifier.
    /// - Parameter userID: The identifier used for authentication.
    public func authenticate(userID: String) async throws {
        let message = ["name": "authenticate", "userId": userID]
        let data = try JSONSerialization.data(withJSONObject: message)
        try await send(data: data)
    }

    /// Registers an async stream for events of the specified name and payload type.
    /// - Parameters:
    ///   - name: The name of the event to observe.
    ///   - type: The expected payload type.
    /// - Returns: An ``AsyncStream`` of decoded payload values.
    public func observeEvent<T: Decodable & Sendable>(
        named name: String,
        as type: T.Type = T.self
    ) -> AsyncStream<T> {
        AsyncStream { continuation in
            let subscription = EventSubscription { data in
                guard
                    let wrapper = try? self.decoder.decode(EventWrapper<T>.self, from: data),
                    wrapper.name == name
                else { return }
                continuation.yield(wrapper.payload)
            }

            if self.handlers[name] == nil {
                self.handlers[name] = []
            }
            self.handlers[name]?.append(subscription)

            continuation.onTermination = { _ in
                Task { await self.remove(subscription, for: name) }
            }
        }
    }

    // MARK: - Private

    private func listen() {
        task?.receive { [weak self] result in
            guard let self else { return }
            Task { await self.handle(result: result) }
        }
    }

    func handle(result: Result<URLSessionWebSocketTask.Message, Error>) async {
        switch result {
        case let .success(message):
            var data: Data?
            switch message {
            case let .data(received):
                data = received
            case let .string(text):
                data = text.data(using: .utf8)
            @unknown default:
                break
            }

            if let data, let name = extractName(from: data), let handlers = handlers[name] {
                for handler in handlers {
                    handler.deliver(data)
                }
            }

            listen()
        case .failure:
            disconnect()
        }
    }

    private func extractName(from data: Data) -> String? {
        guard
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let name = json["name"] as? String
        else { return nil }
        return name
    }

    private func send(data: Data) async throws {
        guard let task else { return }
        try await task.send(.data(data))
    }

    private func remove(_ subscription: EventSubscription, for name: String) {
        guard var array = handlers[name] else { return }
        array.removeAll { $0.id == subscription.id }
        handlers[name] = array
    }
}

private struct EventWrapper<T: Decodable>: Decodable {
    let name: String
    let payload: T

    private enum CodingKeys: String, CodingKey {
        case name
        case payload = "data"
    }
}

private final class EventSubscription: Sendable {
    let id = UUID()
    let deliver: @Sendable (Data) -> Void

    init(deliver: @escaping @Sendable (Data) -> Void) {
        self.deliver = deliver
    }
}
