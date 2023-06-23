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

enum EventFilterTypes {
    static let all: String = "all"
    static let conference: String = "conference"
    static let sport: String = "sport"
    static let festival: String = "festival"
    static let party: String = "party"
    static let cultural: String = "cultural"
}

struct Event: Codable {
    var name: String
    var description: String
    var startDate: Date
    var endDate: Date
    var image: String
    var longitude: Double
    var latitude: Double
    var category: String
}
