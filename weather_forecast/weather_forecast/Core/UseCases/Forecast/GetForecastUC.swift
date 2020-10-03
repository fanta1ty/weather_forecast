//
//  GetForecastUC.swift
//  weather_forecast
//
//  Created by User on 10/1/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import PromiseKit
import ReSwift

final class GetForecastUC: BaseUC {
    private let city: String!
    private let unit: ForecastUnit!
    private let forecastAPI: ForecastAPI!
    
    private let cache = Cache<Forecast>()
    
    init(appStateStore: Store<AppState>, forecastAPI: ForecastAPI, city: String, unit: ForecastUnit) {
        self.forecastAPI = forecastAPI
        self.city = city
        self.unit = unit
        super.init(appStateStore: appStateStore)
    }
    
    override func handleError(error: Error) {
        super.handleError(error: error)
        appStateStore.dispatchOnMain(action: UpdateGetForecastAction(state: .fail(error.localizedDescription)))
    }
}

// MARK: - Public Functions
extension GetForecastUC {
    // MARK: start
    final func start() {
        if let forecast = cache.value(forKey: city) {
            appStateStore.dispatchOnMain(action: UpdateGetForecastAction(state: .result(forecast)))
        } else {
            _ = forecastAPI.getForecast(city: city, unit: unit)
                .done(updateState(state: ))
                .catch(handleError(error: ))
        }
    }
    
    // MARK: stop
    final func stop() {
        
    }
}

// MARK: - Private Functions
extension GetForecastUC {
    // MARK: updateState
    final private func updateState(state: Forecast) {
        cache.insert(state, forKey: city)
        appStateStore.dispatchOnMain(action: UpdateGetForecastAction(state: .result(state)))
    }
}
