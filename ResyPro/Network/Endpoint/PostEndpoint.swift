import Foundation

protocol PostEndpoint<Body>: Endpoint {
    associatedtype Body: NetworkRequestBody
    var requestBody: Body? { get }
}

typealias NetworkRequestBody = Sendable & Encodable
