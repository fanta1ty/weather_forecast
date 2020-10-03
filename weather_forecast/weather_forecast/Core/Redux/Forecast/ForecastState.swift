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
    case GetForecastByCoordinate
}

struct ForecastState {
    // MARK: getForecastState
    let getForecastState = BehaviorRelay<EntityState<Forecast>>(value: .result(nil))
    let getForecastByCoordinateState = PublishRelay<EntityState<Forecast>>()
}

// MARK: - Typealias
typealias GetForecastObservable = Observable<EntityState<Forecast>>
typealias GetForecastByCoordinateObservable = Observable<EntityState<Forecast>>

