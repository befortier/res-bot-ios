//
//  ResyConfig.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData

@Model
final class ResyConfig: Identifiable, Equatable {
    var authToken: String
    var paymentID: String

    init(
        authToken: String,
        paymentID: String
    ) {
        self.authToken = authToken
        self.paymentID = paymentID
    }
}

extension ResyConfig {
    static var stub: ResyConfig {
        ResyConfig(
            authToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJleHAiOjE3MjI2OTAyMTMsInVpZCI6MjAxNzU5NTQsImd0IjoiY29uc3VtZXIiLCJncyI6W10sImxhbmciOiJlbi11cyIsImV4dHJhIjp7Imd1ZXN0X2lkIjo4NDE2MjcwN319.AVH66PakTsbPEgQsOaz1J5LLOEK-6_SDwk7oGJIYREbiKT9VwGiE1nYTCG9zahuMN0Mx5JEXZKtieOEaNmKmF9ldAb2IqK7I-attA91l1krIXSqrmRvmlE6coQ3MqElfG_k0iVKveBJ2aqDuPwnBeX686vJ5L-ct7vKiXh9st1VBf7kN",
            paymentID: "23385560"
        )
    }
}
