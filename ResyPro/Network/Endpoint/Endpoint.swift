import Foundation

protocol Endpoint {
    var baseURL: BaseURL { get }
    var path: String { get }
    var queryParameters: [String: String]? { get }
    var headers: [String: String]? { get }

    var fixturesPath: String? { get }
}

extension Endpoint {
    var fixturesPath: String? { nil }
}
