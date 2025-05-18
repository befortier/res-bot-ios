//
//  EndpointInterpreter.swift
//  Network
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation

#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

/// Utility for converting ``Endpoint`` values into ``URLRequest`` objects.
public struct EndpointInterpreter {
  static func interpret(endpoint: Endpoint) -> URLRequest? {
    guard let url = URL(string: endpoint.baseURL.rawValue + endpoint.path) else { return nil }
    var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    components?.queryItems = endpoint.queryParameters?.map {
      URLQueryItem(name: $0.key, value: $0.value)
    }

    guard let finalURL = components?.url else { return nil }
    var request = URLRequest(url: finalURL)
    request.allHTTPHeaderFields = endpoint.headers

    if let post = endpoint as? any PostEndpoint {
      request.httpMethod = InterpretedHTTPMethod.post.rawValue
      if let body = post.requestBody {
        request.httpBody = try? JSONEncoder().encode(body)
      }
    } else if endpoint is GetEndpoint {
      request.httpMethod = InterpretedHTTPMethod.get.rawValue
    }

    return request
  }
}
