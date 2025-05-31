//
//  HTTPClient.swift
//  Network
//
//  Created by Ben Fortier on 5/26/25.
//

import Foundation
public struct HTTPClient: NetworkClient {
    private let session: any NetworkClient
    private let adapters: [any NetworkAdapter]
    private let policy: any RetryPolicy
    private let clock: any Clock<Duration>

    public init(
        session: any NetworkClient = URLSession.shared,
        adapters: [any NetworkAdapter] = [],
        policy: any RetryPolicy,
        clock: any Clock<Duration> = ContinuousClock()
    ) {
        self.session = session
        self.adapters = adapters
        self.policy = policy
        self.clock = clock
    }

    public func data(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)? = nil
    ) async throws -> (Data, URLResponse) {
        try await execute(request, delegate: delegate)
    }

    // MARK: – Core executor --------------------------------------------------

    @discardableResult
    public func execute(
        _ original: URLRequest,
        delegate: (any URLSessionTaskDelegate)? = nil
    ) async throws -> (Data, URLResponse) {

        var attempt = 0
        var request = try await adapters.adapt(original)

        while true {
            do {
                let (data, response) = try await session.data(for: request, delegate: delegate)
                try classifyAndThrowIfNeeded(response)
                return (data, response)
            } catch {
                let (status, mapped) = map(error: error)

                switch try await policy.decision(for: status, attempt: attempt) {
                case .retry(let delay):
                    attempt += 1
                    if delay > .zero { try await clock.sleep(for: delay) }
                    request = try await adapters.adapt(original)

                case .fail:
                    throw mapped
                }
            }
        }
    }

    // MARK: – helpers (unchanged except key name fix) ------------------------

    private func classifyAndThrowIfNeeded(_ response: URLResponse) throws {
        guard let http = response as? HTTPURLResponse else { return }
        switch http.statusCode {
        case 200..<300: return
        case 401, 403:  throw NetworkError.unauthorized
        case 400..<500: throw NetworkError.clientError(http.statusCode)
        case 500..<600: throw NetworkError.serverError(http.statusCode)
        default:        throw NetworkError.unknown
        }
    }

    private func map(error: Error) -> (Int?, NetworkError) {
        if let urlErr = error as? URLError {
            let ns = urlErr as NSError
            let status = (ns.userInfo[NSURLErrorFailingURLErrorKey]
                          as? HTTPURLResponse)?.statusCode
            return (status, .transport(urlErr))
        }
        if let net = error as? NetworkError { return (nil, net) }
        return (nil, .unknown)
    }
}
