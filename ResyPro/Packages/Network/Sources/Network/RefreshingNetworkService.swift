import Foundation

/// ``NetworkService`` that automatically refreshes the bearer token on 401 or 403 errors.
public actor RefreshingNetworkService: NetworkService {
  private var configuration: ResyHeaderConfiguration
  private let refresher: any TokenRefreshing
  private let session: any NetworkSession
  private let jsonDecoder: JSONDecoder

  /// Creates a ``RefreshingNetworkService``.
  /// - Parameters:
  ///   - configuration: Header values used for the initial request.
  ///   - refresher: Object capable of refreshing the bearer token.
  ///   - session: The underlying session used for requests.
  ///   - jsonDecoder: Decoder for JSON responses.
  public init(
    configuration: ResyHeaderConfiguration,
    refresher: any TokenRefreshing,
    session: any NetworkSession = URLSession.shared,
    jsonDecoder: JSONDecoder = JSONDecoder()
  ) {
    self.configuration = configuration
    self.refresher = refresher
    self.session = session
    self.jsonDecoder = jsonDecoder
  }

  public func fetch<T: Decodable & Sendable>(from endpoint: Endpoint) async throws -> T {
    do {
      return try await makeService().fetch(from: endpoint)
    } catch NetworkError.unauthorized {
      let newToken = try await refresher.refreshToken()
      configuration = ResyHeaderConfiguration(
        userID: configuration.userID,
        bearerToken: newToken,
        resyAuthToken: configuration.resyAuthToken
      )
      return try await makeService().fetch(from: endpoint)
    }
  }

  private func makeService() -> any NetworkService {
    NetworkServiceLive(
      client: BearerHTTPClient(configuration: configuration, session: session),
      jsonDecoder: jsonDecoder
    )
  }
}
