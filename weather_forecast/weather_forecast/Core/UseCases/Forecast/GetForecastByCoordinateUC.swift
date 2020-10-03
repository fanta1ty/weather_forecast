//
//  GetForecastByCoordinateUC.swift
//  weather_forecast
//
//  Created by User on 10/3/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import PromiseKit
import ReSwift

final class GetForecastByCoordinateUC: BaseUC {
    private let lat: Double!
    private let lon: Double!
    
    private let unit: ForecastUnit!
    private let forecastAPI: ForecastAPI!
    
    init(appStateStore: Store<AppState>, forecastAPI: ForecastAPI, lat: Double, lon: Double, unit: ForecastUnit) {
        self.forecastAPI = forecastAPI
        self.lat = lat
        self.lon = lon
        self.unit = unit
        super.init(appStateStore: appStateStore)
    }
    
    override func handleError(error: Error) {
        super.handleError(error: error)
    }
}

// MARK: - Public Functions
extension GetForecastByCoordinateUC {
    // MARK: start
    final func start() {
        _ = forecastAPI.getForecastByCoordinate(lat: lat, lon: lon, unit: unit)
            .done(updateState(state: ))
            .catch(handleError(error: ))
    }
    
    // MARK: stop
    final func stop() {
        
    }
}

// MARK: - Private Functions
extension GetForecastByCoordinateUC {
    // MARK: updateState
    final private func updateState(state: Forecast) {
        appStateStore.dispatchOnMain(action: UpdateGetForecastByCoordinateAction(state: .result(state)))
    }
}
