//
//  SplashVM.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation

final class SplashVM {
    // MARK: UC Properties
    let localSettingsDataStore: LocalSettingsDataStore!
    
    init() {
        self.localSettingsDataStore = mainAssemblerResolver.resolve(LocalSettingsDataStore.self)!
    }
}

// MARK: - Public Functions
extension SplashVM {
    // MARK: loadLocalSetting
    final func loadLocalSetting() {
        _ = localSettingsDataStore.get().done({ localSettings in
            if let localSettings = localSettings {
                globalSettings = localSettings
            } else {
                let defaultSettings = Settings(cacheLifeTime: 1, forecastUnit: .celsius)
                globalSettings = defaultSettings
                _ = self.localSettingsDataStore.set(defaultSettings)
            }
        })
    }
}
