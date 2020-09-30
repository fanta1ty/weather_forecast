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
    case staging = "STAGING"
    case test = "TEST"
}

enum ServerEnvironment: String {
    case development
    case production
    case test
}

enum CoreAssemblyType: String {
    case Store
}

final class CoreAssembly {
    
}


// MARK: - Assembly
extension CoreAssembly: Assembly {
    func assemble(container: Container) {
        setupLogger()
        
        Log.debug(message: "[CoreAssembly] was initialized")
        
        // MARK: Store
        container.register(Store.self, name: CoreAssemblyType.Store.rawValue) { r in
            Store(reducer: appReducer, state: nil)
        }.inObjectScope(.container)
    }
}
