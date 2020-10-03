//
//  CacheVM.swift
//  weather_forecast
//
//  Created by User on 10/3/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import UIKit

final class CacheVM {
    // MARK:
    let localSettingsDataStore: LocalSettingsDataStore!
    let cache = Cache<Forecast>()
    
    init() {
        self.localSettingsDataStore = mainAssemblerResolver.resolve(LocalSettingsDataStore.self)!
    }
}
