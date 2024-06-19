//
//  User.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData

@Model
final class User: Identifiable, Equatable {
    @Attribute(.unique) var id: String
    var name: String
    var email: String
    var createdAt: Date

    init(
        id: String,
        name: String,
        email: String,
        createdAt: Date
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.createdAt = createdAt
    }
}

extension User {
    static var stub: User {
        User(
            id: "some-id",
            name: "Ben Fortier",
            email: "bennett.fortier@gmail.com",
            createdAt: Date(timeIntervalSince1970: 1703714743)
        )
    }
}
