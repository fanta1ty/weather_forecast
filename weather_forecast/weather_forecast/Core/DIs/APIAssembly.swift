//
//  APIAssembly.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import Swinject
import ReSwift

final class APIAssembly {
    let server: ServerEnvironment
    
    init(server: ServerEnvironment) {
        self.server = server
    }
}

// MARK: - Assembly
extension APIAssembly: Assembly {
    func assemble(container: Container) {
        Log.debug(message: "[APIAssembly] was initialized")
        
        // MARK: - Global Section
        // MARK: UserProfileServiceConfiguration
        container.register(GlobalServiceConfiguration.self) { r in
            switch self.server {
            case .development:
                return StandardGlobalServiceConfiguration.development
                
            default:
                return StandardGlobalServiceConfiguration.production
            }
        }
        
        // MARK: - Forecase Section
        // MARK: ForecastAPI
        container.register(ForecastAPI.self) { r in
            ImplementForecastAPI(serverConfig: r.resolve(GlobalServiceConfiguration.self)!)
        }
    }
}
