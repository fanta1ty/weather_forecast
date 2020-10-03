//
//  ForecastUnitVM.swift
//  weather_forecast
//
//  Created by User on 10/3/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import UIKit

final class ForecastUnitVM {
    // MARK:
    let localSettingsDataStore: LocalSettingsDataStore!
    
    init() {
        self.localSettingsDataStore = mainAssemblerResolver.resolve(LocalSettingsDataStore.self)!
    }
}
