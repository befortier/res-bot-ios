import Foundation

struct EndpointInterpreter {
    static func interpret(endpoint: Endpoint) -> URLRequest? {
        guard let url = URL(string: endpoint.baseURL.rawValue + endpoint.path) else { return nil }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = endpoint.queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let finalURL = components?.url else { return nil }
        var request = URLRequest(url: finalURL)
        request.allHTTPHeaderFields = endpoint.headers
        return request
    }
}