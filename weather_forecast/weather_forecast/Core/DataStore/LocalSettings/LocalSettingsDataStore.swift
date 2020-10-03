//
//  LocalSettingsDataStore.swift
//  weather_forecast
//
//  Created by User on 10/3/20.
//  Email:thinhnguyen12389@gmail.com
//

import Foundation
import PromiseKit

enum LocalSettingsDataStoreError: Error {
    case notExisted
    case failedToParse
    case unExpectedError(error: Error)
}

protocol LocalSettingsDataStore {
    func get() -> Promise<Settings?>
    func set(_ settings: Settings) -> Promise<()>
    func reset() -> Promise<()>
}
