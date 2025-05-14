//  User.swift
//  User
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftData

@Model
public final class User: Identifiable, Equatable {
    @Attribute(.unique) public var id: String
    public var name: String
    public var email: String
    public var createdAt: Date

    public init(
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
    public static var stub: User {
        User(
            id: "some-id",
            name: "Ben Fortier",
            email: "bennett.fortier@gmail.com",
            createdAt: Date(timeIntervalSince1970: 1703714743)
        )
    }
}
