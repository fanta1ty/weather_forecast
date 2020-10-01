//
//  FeelsLike.swift
//  weather_forecast
//
//  Created by User on 9/30/20.
//

import Foundation

struct FeelsLike: Codable {
    let day: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

// MARK: - Equatable
extension FeelsLike: Equatable {
    static func ==(lhs: FeelsLike, rhs: FeelsLike) -> Bool {
        return lhs.day == rhs.day && lhs.night == rhs.night && lhs.eve == rhs.eve && lhs.morn == rhs.morn
    }
}
