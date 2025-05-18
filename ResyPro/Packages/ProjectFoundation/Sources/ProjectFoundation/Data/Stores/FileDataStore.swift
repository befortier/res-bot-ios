import Combine
import Foundation

/// ``DataStore`` implementation backed by a JSON file on disk.
@MainActor
public final class FileDataStore<T: Codable & Equatable>: DataStore, ObservableObject {
  @Published public private(set) var current: T?
  public var publisher: AnyPublisher<T?, Never> { $current.eraseToAnyPublisher() }

  private let url: URL
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()

  /// Creates a ``FileDataStore`` reading and writing to the specified file URL.
  /// - Parameter url: Location of the JSON file used for persistence.
  public init(url: URL) {
    self.url = url
    if let data = try? Data(contentsOf: url) {
      current = try? decoder.decode(T.self, from: data)
    }
  }

  public func setCurrent(to newData: T?) {
    current = newData
    if let newData,
      let data = try? encoder.encode(newData)
    {
      try? data.write(to: url, options: [.atomic])
    } else {
      try? FileManager.default.removeItem(at: url)
    }
  }
}
