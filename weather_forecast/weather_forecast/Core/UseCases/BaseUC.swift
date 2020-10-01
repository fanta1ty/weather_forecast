//
//  BaseUC.swift
//  weather_forecast
//
//  Created by User on 10/1/20.
//

import Foundation
import PromiseKit
import ReSwift

class BaseUC {
    let appStateStore: Store<AppState>
    var allowHandleError: Bool = true
    
    init(appStateStore: Store<AppState>) {
        self.appStateStore = appStateStore
    }
    
    func handleError(error: Error) {
        
    }
}
