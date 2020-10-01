//
//  CityCoordinate.swift
//  weather_forecast
//
//  Created by User on 9/30/20.
//

import Foundation

struct CityCoordinate: Codable {
    let lon: Double?
    let lat: Double?
}

// MARK: - Equatable
extension CityCoordinate: Equatable {
    static func ==(lhs: CityCoordinate, rhs: CityCoordinate) -> Bool {
        return lhs.lon == rhs.lon && lhs.lat == rhs.lat
    }
}
