//
//  ForecastItem.swift
//  weather_forecast
//
//  Created by User on 9/30/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation

struct ForecastItem {
    enum JSONKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, feelsLike = "feels_like", pressure, humidity, weather, speed, deg, clouds, pop
    }
    
    let dt: Double?
    let sunrise: Double?
    let sunset: Double?
    let temp: Temperature?
    let feelsLike: FeelsLike?
    let pressure: Double?
    let humidity: Double?
    let weather: [Weather]?
    let speed: Double?
    let deg: Double?
    let clouds: Double?
    let pop: Double?
}

// MARK: - Encodable
extension ForecastItem: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: JSONKeys.self)
        
        try container.encodeIfPresent(dt, forKey: .dt)
        try container.encodeIfPresent(sunrise, forKey: .sunrise)
        try container.encodeIfPresent(sunset, forKey: .sunset)
        try container.encodeIfPresent(temp, forKey: .temp)
        try container.encodeIfPresent(feelsLike, forKey: .feelsLike)
        try container.encodeIfPresent(pressure, forKey: .pressure)
        try container.encodeIfPresent(humidity, forKey: .humidity)
        try container.encodeIfPresent(weather, forKey: .weather)
        try container.encodeIfPresent(speed, forKey: .speed)
        try container.encodeIfPresent(deg, forKey: .deg)
        try container.encodeIfPresent(clouds, forKey: .clouds)
        try container.encodeIfPresent(pop, forKey: .pop)
    }
}

// MARK: - Decodable
extension ForecastItem: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: JSONKeys.self)
        
        dt = try values.decodeIfPresent(Double.self, forKey: .dt)
        sunrise = try values.decodeIfPresent(Double.self, forKey: .sunrise)
        sunset = try values.decodeIfPresent(Double.self, forKey: .sunset)
        temp = try values.decodeIfPresent(Temperature.self, forKey: .temp)
        feelsLike = try values.decodeIfPresent(FeelsLike.self, forKey: .feelsLike)
        pressure = try values.decodeIfPresent(Double.self, forKey: .pressure)
        humidity = try values.decodeIfPresent(Double.self, forKey: .humidity)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        speed = try values.decodeIfPresent(Double.self, forKey: .speed)
        deg = try values.decodeIfPresent(Double.self, forKey: .deg)
        clouds = try values.decodeIfPresent(Double.self, forKey: .clouds)
        pop = try values.decodeIfPresent(Double.self, forKey: .pop)
    }
}
// MARK: - Equatable
extension ForecastItem: Equatable {
    static func ==(lhs: ForecastItem, rhs: ForecastItem) -> Bool {
        return lhs.dt == rhs.dt && lhs.sunrise == rhs.sunrise && lhs.sunset == rhs.sunset && lhs.temp == rhs.temp && lhs.feelsLike == rhs.feelsLike && lhs.pressure == rhs.pressure && lhs.humidity == rhs.humidity && lhs.weather == rhs.weather && lhs.speed == rhs.speed && lhs.deg == rhs.deg && lhs.clouds == rhs.clouds && lhs.pop == rhs.pop
    }
}
