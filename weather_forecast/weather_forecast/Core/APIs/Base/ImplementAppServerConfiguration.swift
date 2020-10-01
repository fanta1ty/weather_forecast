//
//  ImplementAppServerConfiguration.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import TSwiftHelper

public enum StandardGlobalServiceConfiguration: GlobalServiceConfiguration {
    case development
    case production
    
    public var baseURL: String {
        switch self {
        case .development:
            return "https://api.openweathermap.org/data/2.5/"
        case .production:
            return "https://api.openweathermap.org/data/2.5/"
        }
    }
}
