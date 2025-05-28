import SwiftUI
import User

/// Provides a ``BootstrapUseCase`` via the SwiftUI environment.
extension EnvironmentValues {
    /// The ``BootstrapUseCase`` used to initialize the app.
    @Entry public var bootstrapUseCase: any BootstrapUseCase = FatalErrorBootstrapUseCase()
}

/// Fallback implementation that traps when used without being injected.
public struct FatalErrorBootstrapUseCase: BootstrapUseCase {
    public init() {}
    public func callAsFunction(user: User?) async {
        fatalError("BootstrapUseCase not injected into environment")
    }
}
