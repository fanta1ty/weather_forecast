//
//  AppReducer.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email:thinhnguyen12389@gmail.com
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    switch action {
    default:
        state.forecastState = forecastReducer(action: action, state: state.forecastState)
    }
    
    return state
}
