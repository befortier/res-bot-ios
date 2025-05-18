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

    /*
     VENUE_ID=2790
     DATE=2024-07-18
     EARLIEST=17:00
     LATEST=18:00
     PARTY_SIZE=2
     PAYMENT_ID=23385560
     AUTH_TOKEN=eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJleHAiOjE3MjI2OTAyMTMsInVpZCI6MjAxNzU5NTQsImd0IjoiY29uc3VtZXIiLCJncyI6W10sImxhbmciOiJlbi11cyIsImV4dHJhIjp7Imd1ZXN0X2lkIjo4NDE2MjcwN319.AVH66PakTsbPEgQsOaz1J5LLOEK-6_SDwk7oGJIYREbiKT9VwGiE1nYTCG9zahuMN0Mx5JEXZKtieOEaNmKmF9ldAb2IqK7I-attA91l1krIXSqrmRvmlE6coQ3MqElfG_k0iVKveBJ2aqDuPwnBeX686vJ5L-ct7vKiXh9st1VBf7kN
     */

//    private let context = CoreDataManager.shared.persistentContainer.viewContext
    private let networkService: any NetworkService

    init(
        networkService: any NetworkService = {
#if DEBUG
            DebugNetworkServiceLive()
#else
            NetworkServiceLive(
                client: URLSession.shared,
                jsonDecoder: JSONDecoder()
            )
#endif
        }(),
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
