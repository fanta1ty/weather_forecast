//
//  ImplementAPIProvider.swift
//  weather_forecast
//
//  Created by User on 9/30/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import PromiseKit
import Alamofire
import TSwiftHelper

public enum Task {
    case request
}

public protocol TargetType {
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: [String: Any]? { get }
    
    var parameterList: [[String: Any]?]? {get}
    
    var headers: [String: String]? {get}
    
    var encoding: ParameterEncoding {get}
    
    var task: Task { get }
}


struct ImplementAPIProvider<MapingModel: Decodable, Target: TargetType> {
    let configuration: AppServerConfiguration
    init(configuration: AppServerConfiguration) {
        self.configuration = configuration
    }
}

extension ImplementAPIProvider {
    public func request<T: Decodable>(target: Target, keyPath: String? = nil) -> Promise<T> {
        return Promise<T> { r in
            self.dataRequest(target: target).responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .failure(let error):
                    r.reject(error)
                    
                case .success(let data):
                    r.fulfill(data)
                }
            }
        }
    }
}

extension ImplementAPIProvider {
    // MARK: dataRequest
    private func dataRequest(target: Target) -> DataRequest {
        let baseUrl = URL(string: configuration.baseURL)!
        let url = baseUrl.appendingPathComponent(target.path)
        let params = target.parameters
        let method = target.method
        let headers = target.headers ?? [:]
        let encoding = target.encoding
        
        return AF.request(url, method: method, parameters: params, encoding: encoding, headers: HTTPHeaders(headers), interceptor: nil, requestModifier: nil).validate().responseJSON { response in
            if let error = response.error {
                Log.error("Request \(String(describing: response.request)) error :\(error.localizedDescription)")
            } else {
                Log.verbose("[RemoteAPI Provider] Response from \(target) is \(response)")
            }
        }
    }
}
