import ProjectFoundation

/// Convenience alias for a persisted ``TokenStore`` using ``FileDataStore``.
public typealias TokenStoreFile = FileDataStore<TokenPair>

extension FileDataStore where T == TokenPair {
  /// Creates a ``FileDataStore`` at the default token path inside the documents directory.
  public convenience init() {
    let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    self.init(url: directory.appendingPathComponent("token-pair.json"))
  }
}
