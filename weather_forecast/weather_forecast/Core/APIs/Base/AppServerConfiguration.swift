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

public protocol GlobalServiceConfiguration: AppServerConfiguration {}
public protocol SocketServiceConfiguration: AppServerConfiguration {}
public protocol UserProfileServiceConfiguration: AppServerConfiguration {}
public protocol GoogleMapConfiguration: AppServerConfiguration {}
public protocol SymptomCheckerServiceConfiguration: AppServerConfiguration {
    var appId: String { get }
    var appKey: String { get }
}
