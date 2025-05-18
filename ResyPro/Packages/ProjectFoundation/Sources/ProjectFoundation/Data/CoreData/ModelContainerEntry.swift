import SwiftUI
@preconcurrency import SwiftData

/// An environment entry used to supply a ``ModelContainerProtocol`` implementation.

extension EnvironmentValues {
    /// The container available in the environment.
     @Entry public var projectModelContainer: any ModelContainerProtocol = FatalErrorModelContainer()
}

/// A fallback container that traps if accessed without being overridden in the environment.
struct FatalErrorModelContainer: ModelContainerProtocol {
    var mainContext: ModelContext {
        fatalError("ModelContainer not injected into environment")
    }
}
