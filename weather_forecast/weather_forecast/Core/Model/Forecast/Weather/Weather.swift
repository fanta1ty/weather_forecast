//
//  Weather.swift
//  weather_forecast
//
//  Created by User on 9/30/20.
//

import Foundation

enum WeatherCondition: String, Codable, CodingKey {
    case thunderstorm = "Thunderstorm", drizzle = "Drizzle", rain = "Rain", snow = "Snow", mist = "Mist", smoke = "Smoke", haze = "Haze", dust = "Dust", fog = "Fog", sand = "Sand", ash = "Ash", squall = "Squall", tornado = "Tornado", clear = "Clear", clouds = "Clouds"
}

struct Weather {
    enum JSONKeys: String, CodingKey {
        case id, main, desc = "description", icon, iconURL
    }
    
    let id: Double?
    let main: WeatherCondition?
    let desc: String?
    let icon: String?
    var iconURL: String?
}

// MARK: - Encodable
extension Weather: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: JSONKeys.self)
        
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(main, forKey: .main)
        try container.encodeIfPresent(desc, forKey: .desc)
        try container.encodeIfPresent(icon, forKey: .icon)
        try container.encodeIfPresent(iconURL, forKey: .iconURL)
    }
}

// MARK: - Decodable
extension Weather: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: JSONKeys.self)
        
        id = try values.decodeIfPresent(Double.self, forKey: .id)
        main = try values.decodeIfPresent(WeatherCondition.self, forKey: .main)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        
        if let icon = icon {
            iconURL = "https://openweathermap.org/img/wn/" + icon + "@2x.png"
        }
    }
}

// MARK: - Equatable
extension Weather: Equatable {
    static func ==(lhs: Weather, rhs: Weather) -> Bool {
        return lhs.id == rhs.id
    }
}
