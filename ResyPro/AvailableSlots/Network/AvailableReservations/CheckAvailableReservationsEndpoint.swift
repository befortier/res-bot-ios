//
//  CheckAvailableReservationsEndpoint.swift
//  ResyPro
//
//  Created by OpenAI on 6/25/24.
//

import Foundation
import Network

struct CheckAvailableReservationsEndpoint: PostEndpoint {
	let baseURL: BaseURL = .backend
	let path: String = "/available-reservations"
	let queryParameters: [String: String]? = nil
	let headers: [String: String]? = ["Content-Type": "application/json"]

	let requestBody: CheckAvailableReservationsRequest?

	init(requestBody: CheckAvailableReservationsRequest) {
		self.requestBody = requestBody
	}
}
