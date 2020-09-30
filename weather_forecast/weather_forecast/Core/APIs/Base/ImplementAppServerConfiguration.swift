//
//  ImplementAppServerConfiguration.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import TSwiftHelper

public enum StandardUserProfileApiConfiguration: UserProfileServiceConfiguration {
    case development
    case production
    case test
    
    public var baseURL: String {
        switch self {
        case .development:
            return "https://api.openweathermap.org/data/2.5/forecast/"
        
        case .test:
            return "https://api.openweathermap.org/data/2.5/forecast/"
        
        case .production:
            return "https://api.openweathermap.org/data/2.5/forecast/"
        }
    }
}


public enum StandardGlobalServiceConfiguration: GlobalServiceConfiguration {
    case development
    case production
    
    public var baseURL: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }
}

public enum StandardSocketServiceConfiguration: SocketServiceConfiguration {
    case development
    case production
    
    public var baseURL: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }
}

public enum StandardGoogleMapConfiguration: GoogleMapConfiguration {
    case development
    case production
    
    public var baseURL: String {
        switch self {
        default:
            return ""
        }
    }
}
