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
    public var profileImageURL: URL?
    public var preferredLocation: String
    public var resyAuthToken: String?
    public var resyPaymentID: String?

    public init(
        id: String,
        name: String,
        email: String,
        createdAt: Date,
        profileImageURL: URL? = nil,
        preferredLocation: String = "",
        resyAuthToken: String? = nil,
        resyPaymentID: String? = nil
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.createdAt = createdAt
        self.profileImageURL = profileImageURL
        self.preferredLocation = preferredLocation
        self.resyAuthToken = resyAuthToken
        self.resyPaymentID = resyPaymentID
    }
}

extension User {
    public static var stub: User {
        User(
            id: "abc",
            name: "Ben Fortier",
            email: "bennett.fortier@gmail.com",
            createdAt: Date(timeIntervalSince1970: 1703714743),
            profileImageURL: URL(string: "https://example.com/profile.jpg"),
            preferredLocation: "New York, NY",
            resyAuthToken: "example-token",
            resyPaymentID: "23385560"
        )
    }
}


extension String {
    public static let stubResyToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJleHAiOjE3NTExNDg0ODcsInVpZCI6MjAxNzU5NTQsImd0IjoiY29uc3VtZXIiLCJncyI6W10sImxhbmciOiJlbi11cyIsImV4dHJhIjp7Imd1ZXN0X2lkIjo4NDE2MjcwN319.AMZb1EK_GTMQcp-bv4NZXQQqGmapIZP7Ld_qdkx6LFMdL1CQUNTz3Idg388jMu-9QKKOUdMsdBUelq6-LEBhKfrtAF7_B0ZQ0WLUKvuwnuurGZKTsTs8-xVLQK6paC4wBOUkjxEVORGkyH8vTYiVW1kanQzs-7uSTGPb5a9yFn5KfCN-"
}
