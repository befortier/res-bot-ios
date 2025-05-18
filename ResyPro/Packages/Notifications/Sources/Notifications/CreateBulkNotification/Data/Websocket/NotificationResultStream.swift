import Foundation
import Websockets

extension WebsocketClient {
  /// Streams bulk notification results from the server.
  /// - Returns: An ``AsyncStream`` of ``NotificationSubmissionResponse.ResultEntry`` values.
  public func notificationResultStream() async -> AsyncStream<
    NotificationSubmissionResponse.ResultEntry
  > {
    await observeEvent(
      named: "notification-result",
      as: NotificationSubmissionResponse.ResultEntry.self
    )
  }
}
