//
//  ForecastReducer.swift
//  weather_forecast
//
//  Created by User on 10/1/20.
//

import Foundation
import ReSwift
import RxSwift

func forecastReducer(action: Action, state: ForecastState?) -> ForecastState {
    let state = state ?? ForecastState()
    switch action {
        
    // MARK: - GetServiceOption
    case let action as UpdateGetForecastAction:
        state.getForecastState.accept(action.state)
        
    case _ as ClearGetForecastAction:
        state.getForecastState.accept(.result(nil))
        
    default:
        break
    }
    
    return state
}
