//
//  ForecastAPI.swift
//  weather_forecast
//
//  Created by User on 9/30/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import UIKit
import PromiseKit

enum ForecastAPIError {
    case unexpectedError(message: String)
    case unknown
}

extension ForecastAPIError {
    var localizedDescription: String {
        switch self {
        case .unexpectedError(let message):
            return message
            
        default:
            return "Unknown Error"
        }
    }
}

protocol ForecastAPI {
    func getForecast(city: String) -> Promise<Forecast>
}
