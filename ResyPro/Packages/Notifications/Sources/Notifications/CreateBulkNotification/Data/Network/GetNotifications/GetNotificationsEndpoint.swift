//
//  GetNotificationsEndpoint.swift
//  Notifications
//
//  Created by Ben Fortier on 5/30/25.
//

import Network

/// ``Endpoint`` for retrieving all notifications.
struct GetNotificationsEndpoint: GetEndpoint {
    let baseURL: BaseURL = .backend
    let path: String = "/notifications"
    let queryParameters: [String: String]? = nil
    let headers: [String: String]? = ["Content-Type": "application/json"]
}
