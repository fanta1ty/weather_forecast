//
//  ImplementLocalSettingsDataStore.swift
//  weather_forecast
//
//  Created by User on 10/3/20.
//  Email:thinhnguyen12389@gmail.com
//

import Foundation
import PromiseKit

final class ImplementLocalSettingsDataStore {
    private let accessKey = "localSettings"
}

// MARK: - LocalServiceDataStore
extension ImplementLocalSettingsDataStore: LocalSettingsDataStore {
    // MARK: get
    func get() -> Promise<Settings?> {
        return Promise { r in
            guard let data = UserDefaults.standard.object(forKey: self.accessKey) as? Data else {
                r.fulfill(nil)
                return
            }
            
            let decoder = JSONDecoder()
            
            guard let decodedData = try? decoder.decode(Settings.self, from: data) else {
                r.fulfill(nil)
                return
            }
            
            r.fulfill(decodedData)
        }
    }
    
    func set(_ settings: Settings) -> Promise<()> {
        return Promise { r in
            let encoder = JSONEncoder()
            guard let encodedData = try? encoder.encode(settings) else {
                r.reject(LocalSettingsDataStoreError.failedToParse)
                return
            }
            
            UserDefaults.standard.setValue(encodedData, forKey: self.accessKey)
            UserDefaults.standard.synchronize()
            r.fulfill(())
        }
    }
    
    // MARK: reset
    func reset() -> Promise<()> {
        return Promise { r in
            UserDefaults.standard.removeObject(forKey: self.accessKey)
            UserDefaults.standard.synchronize()
            r.fulfill(())
        }
    }
}
