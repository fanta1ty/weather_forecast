//
//  UseCaseAssembly.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import Swinject
import ReSwift
import RxSwift

final class UseCaseAssembly {
    
}


// MARK: - Assembly
extension UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        Log.debug(message: "[UseCaseAssembly] was initialized")
        
        // MARK: - Forecast Section
        // MARK: GetForecastUC
        container.register(GetForecastUC.self) { r, city, unit in
            GetForecastUC(appStateStore: r.resolve(Store.self)!, forecastAPI: r.resolve(ForecastAPI.self)!, city: city, unit: unit)
        }
    }
}
