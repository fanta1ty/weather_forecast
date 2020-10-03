//
//  CoreAssembly.swift
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

enum AppEnvironment: String {
    case development = "DEVELOPMENT"
    case production = "PRODUCTION"
}

enum ServerEnvironment: String {
    case development
    case production
}

final class CoreAssembly {
    
}


// MARK: - Assembly
extension CoreAssembly: Assembly {
    func assemble(container: Container) {
        setupLogger()
        
        Log.debug(message: "[CoreAssembly] was initialized")
        
        // MARK: Store
        container.register(Store.self) { r in
            Store(reducer: appReducer, state: nil)
        }.inObjectScope(.container)
        
        // MARK: LocalSettingsDataStore
        container.register(LocalSettingsDataStore.self) { r in
            ImplementLocalSettingsDataStore()
        }.inObjectScope(.container)
    }
}
