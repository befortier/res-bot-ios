//
//  CreateReservationViewModel.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Combine
import SwiftUI
import Network
#if DEBUG
import DebugTools
#endif

class CreateReservationViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var venueID = "2790"
    @Published var date = "2024-07-18"
    @Published var time = ""
    @Published var partySize = ""

    let resyConfig: ResyConfig

    private let networkService: any NetworkService

    init(
        networkService: any NetworkService,
        resyConfig: ResyConfig
    ) {
        self.networkService = networkService
        self.resyConfig = resyConfig
    }

//    func saveCredentials() {
//        let credentials = UserCredentials(context: context)
//        credentials.username = username
//        credentials.password = password
//        CoreDataManager.shared.saveContext()
//    }
//
//    func makeReservation() async throws {
//        let bookingToken
//
//        networkService.makeReservation(with: request) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let response):
//                    completion(response.success)
//                case .failure(let error):
//                    print("Reservation failed: \(error)")
//                    completion(false)
//                }
//            }
//        }
//    }
}
