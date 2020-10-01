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
    private let forecastAPI: ForecastAPI!
    
    init(appStateStore: Store<AppState>, forecastAPI: ForecastAPI, city: String) {
        self.forecastAPI = forecastAPI
        self.city = city
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
        _ = forecastAPI.getForecast(city: city)
            .done(updateState(state: ))
            .catch(handleError(error: ))
    }
    
    // MARK: stop
    final func stop() {
        
    }
}

// MARK: - Private Functions
extension GetForecastUC {
    // MARK: updateState
    final private func updateState(state: Forecast) {
        appStateStore.dispatchOnMain(action: UpdateGetForecastAction(state: .result(state)))
    }
}
