//
//  AppServerConfiguration.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import TSwiftHelper

class AppRemoteAPI {
    let serverConfig: AppServerConfiguration
    
    init(serverConfig: AppServerConfiguration) {
        self.serverConfig = serverConfig
    }
}

public protocol GlobalServiceConfiguration: AppServerConfiguration {}
