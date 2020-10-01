//
//  Temperature.swift
//  weather_forecast
//
//  Created by User on 9/30/20.
//

import Foundation

struct Temperature: Codable {
    let day: Double?
    let min: Double?
    let max: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

// MARK: - Equatable
extension Temperature: Equatable {
    static func ==(lhs: Temperature, rhs: Temperature) -> Bool {
        return lhs.day == rhs.day && lhs.min == rhs.min && lhs.max == rhs.max && lhs.night == rhs.night && lhs.eve == rhs.eve && lhs.morn == rhs.morn
    }
}
