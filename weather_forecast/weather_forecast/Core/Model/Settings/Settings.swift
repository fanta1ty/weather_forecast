//
//  Settings.swift
//  weather_forecast
//
//  Created by User on 10/3/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation

struct Settings: Codable {
    var cacheLifeTime: Int?
    var forecastUnit: ForecastUnit?
}

// MARK: - Equatable
extension Settings: Equatable {
    static func ==(lhs: Settings, rhs: Settings) -> Bool {
        return lhs.cacheLifeTime == rhs.cacheLifeTime
    }
}
