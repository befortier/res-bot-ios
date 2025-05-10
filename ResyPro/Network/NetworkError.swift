import Foundation

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case unknown
}