import SwiftUI
import Combine
import ProjectFoundation

extension EnvironmentValues {
    /// The ``TokenStore`` available in the environment.
    @Entry public var tokenStore: TokenStore = FatalErrorTokenStore()
}

/// Fallback store that traps when accessed without being injected.
public final class FatalErrorTokenStore: TokenStore {
    public var current: TokenPair? { fatalError("TokenStore not injected into environment") }
    public var publisher: AnyPublisher<TokenPair?, Never> { fatalError("TokenStore not injected into environment") }
    public init() {}
    public func setCurrent(to newData: TokenPair?) {
        fatalError("TokenStore not injected into environment")
    }
}
