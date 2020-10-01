//
//  ForecastAction.swift
//  weather_forecast
//
//  Created by User on 10/1/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import ReSwift
import RxSwift

// MARK: - GetForecast
struct UpdateGetForecastAction: Action {
    let state: EntityState<Forecast>
}

struct ClearGetForecastAction: Action {
    
}
