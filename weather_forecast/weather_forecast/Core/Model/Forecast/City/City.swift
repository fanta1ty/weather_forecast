//
//  City.swift
//  weather_forecast
//
//  Created by User on 9/30/20.
//

import Foundation

struct City: Codable {
    let id: Double?
    let name: String?
    let coord: CityCoordinate?
    let country: String?
    let population: Double?
    let timezone: Double?
}

// MARK: - Equatable
extension City: Equatable {
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
