import Foundation

final class EnvironmentStore {
    static let shared = EnvironmentStore()
    var currentEnvironment: BaseURL = .resy
}