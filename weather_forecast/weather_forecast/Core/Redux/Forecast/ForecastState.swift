//
//  ForecastState.swift
//  weather_forecast
//
//  Created by User on 10/1/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import RxSwift
import RxCocoa

enum ForecastStateType: String {
    case GetForecast
}

struct ForecastState {
    // MARK: getForecastState
    let getForecastState = BehaviorRelay<EntityState<Forecast>>(value: .result(nil))
}

// MARK: - Typealias
typealias GetForecastObservable = Observable<EntityState<Forecast>>

