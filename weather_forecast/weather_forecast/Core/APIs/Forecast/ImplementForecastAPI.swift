//
//  ImplementForecastAPI.swift
//  weather_forecast
//
//  Created by User on 10/1/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import PromiseKit
import Alamofire
import TSwiftHelper

// MARK: - SupportToolAPITarget Section
enum ForecastAPITarget {
    case getForecast(city: String)
}

extension ForecastAPITarget: TargetType {
    var path: String {
        switch self {
        default:
            return "forecast/daily"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getForecast(let city):
            return ["q": city, "cnt": 7, "appid": APP_ID, "units": "metric"]
        }
    }
    
    var parameterList: [[String : Any]?]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var task: Task {
        return .request
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getForecast(_):
            return URLEncoding.queryString
        }
    }
}

// MARK: - ImplementBannerAPI
final class ImplementForecastAPI: AppRemoteAPI {
    private let provider: ImplementAPIProvider<Forecast, ForecastAPITarget>
    
    override init(serverConfig: AppServerConfiguration) {
        self.provider = ImplementAPIProvider<Forecast, ForecastAPITarget>(configuration: serverConfig)
        super.init(serverConfig: serverConfig)
    }
}

// MARK: - ForecastAPI
extension ImplementForecastAPI: ForecastAPI {
    // MARK: getForecast
    func getForecast(city: String) -> Promise<Forecast> {
        return provider.request(target: .getForecast(city: city))
    }
}
