//
//  Event.swift
//  EventsApp
//
//  Created by Páll Arnold-Barna on 22.03.2023.
//

import Foundation

enum EventCategories {
    static let conference: String = "Conference"
    static let sport: String = "Sport"
    static let festival: String = "Festival"
    static let party: String = "Party"
    static let cultural: String = "Cultural"
}

struct Event: Codable {
    var name: String
    var description: String
    var startDate: Date
    var endDate: Date
    var image: String
    var locationAddress: String
    var category: String
}
