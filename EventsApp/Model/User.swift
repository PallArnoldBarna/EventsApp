//
//  User.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 22.03.2023.
//

import Foundation

enum UserType {
    static let user: String = "user"
    static let admin: String = "admin"
}

struct User: Codable {
    var username: String
    var userType: String
    var favouriteEvents: [Event]
}
