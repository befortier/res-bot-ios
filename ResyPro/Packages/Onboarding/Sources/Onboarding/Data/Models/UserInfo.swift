//
//  UserInfo.swift
//  Onboarding
//
//  Created by Ben Fortier on 5/28/25.
//

public import Foundation

public struct UserInfo: Codable, Sendable {
    public let userID: String
    public let firstName: String
    public let lastName: String
}
