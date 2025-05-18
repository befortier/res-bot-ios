import Combine
import Foundation

public final class FileDataStore<T: Codable & Equatable & Sendable>: DataStore, ObservableObject, @unchecked Sendable {
  @Published public private(set) var current: T?
  public var publisher: AnyPublisher<T?, Never> { $current.eraseToAnyPublisher() }

  private let url: URL
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()

  /// A serial queue to ensure thread-safe read/write operations.
  private let queue = DispatchQueue(label: "com.yourapp.filedatastore")

  public init(url: URL) {
    self.url = url
    if let data = try? Data(contentsOf: url) {
      current = try? decoder.decode(T.self, from: data)
    }
  }

  public func setCurrent(to newData: T?) {
    queue.async {
      DispatchQueue.main.async { @Sendable in
        self.current = newData // must mutate @Published on main queue
      }

      if let newData, let data = try? self.encoder.encode(newData) {
        try? data.write(to: self.url, options: [.atomic])
      } else {
        try? FileManager.default.removeItem(at: self.url)
      }
    }
  }
}
