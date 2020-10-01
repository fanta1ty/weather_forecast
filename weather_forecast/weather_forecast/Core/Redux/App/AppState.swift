//
//  AppState.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email:thinhnguyen12389@gmail.com
//

import Foundation
import ReSwift
import RxSwift
import RxCocoa

enum TokenStateType: String {
    case deviceToken
    case otherToken
}

// MARK: - EntityState Section
enum EntityState<T: Equatable> {
    case result(T?)
    case fail(String)
}

extension EntityState: Equatable {
    static func ==<T>(lhs: EntityState<T>, rhs: EntityState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.fail, .fail):
            return true
            
        case (.result(let t1), .result(let t2)):
            return t1 == t2
            
        default:
            return false
        }
    }
}

// MARK: EntityArrayState Section
enum EntityArrayState<T: Equatable> {
    case result([T]?)
    case fail(String)
}

extension EntityArrayState: Equatable {
    static func ==<T>(lhs: EntityArrayState<T>, rhs: EntityArrayState<T>) -> Bool {
        
        switch (lhs, rhs) {
        case (.fail, .fail):
            return true
            
        case (.result(let t1), .result(let t2)):
            return t1 == t2
            
        default:
            return false
        }
    }
}

// MARK: - AppState Section
enum AppStateType: String {
    case None
}

struct AppState: StateType {
    var error: Error?
    
    // MARK: forecastState
    var forecastState = ForecastState()
}
