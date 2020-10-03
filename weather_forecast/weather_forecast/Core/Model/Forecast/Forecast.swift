//
//  Forecast.swift
//  weather_forecast
//
//  Created by User on 9/30/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation

enum ForecastUnit: String {
    case kelvin = "standard", celsius = "metric", fahrenheit = "imperial"
}

extension ForecastUnit {
    var unitText: String {
        switch self {
        case .celsius:
            return "℃"
            
        case .fahrenheit:
            return "℉"
            
        default:
            return "K"
        }
    }
}

struct Forecast: Codable {
    let city: City?
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [ForecastItem]?
}

// MARK: - Equatable
extension Forecast: Equatable {
    static func ==(lhs: Forecast, rhs: Forecast) -> Bool {
        return lhs.cod == rhs.cod && lhs.message == rhs.message && lhs.cnt == rhs.cnt && lhs.city == rhs.city && lhs.list == rhs.list
    }
}
