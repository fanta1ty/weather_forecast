//
//  HomeVM.swift
//  weather_forecast
//
//  Created by User on 3/9/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import UIKit
import SwiftLocation

final class HomeVM {
    // MARK: UC Properties
    let cache = Cache<Forecast>()
    var currentForecast: Forecast?
    var responsedForecast: Forecast?
    var currentForecastItem: ForecastItem?
    
    let forecastUnits = ["Metric: ℃", "Imperial: ℉"]
    var allowRefreshData: Bool = false
    
    let getForecastUC: ((String, ForecastUnit) -> GetForecastUC)!
    let getForecastByCoordinateUC: ((Double, Double, ForecastUnit) -> GetForecastByCoordinateUC)
    var searchs: [ForecastItem] = [ForecastItem]()
    
    init() {
        self.getForecastUC = { city, unit in
            mainAssemblerResolver.resolve(GetForecastUC.self, arguments: city, unit)!
        }
        
        self.getForecastByCoordinateUC = { lat, lon, unit in
            mainAssemblerResolver.resolve(GetForecastByCoordinateUC.self, arguments: lat, lon, unit)!
        }
    }
}

// MARK: - Public Function - UI
extension HomeVM {
    // MARK: enableSearchBar
    final func enableSearchBar(_ searchBar: UISearchBar, enable: Bool = true, searchedText: String? = "") {
        
        if let searchedText = searchedText, searchedText.isEmpty {
            searchBar.text = nil
        }
        
        searchBar.setShowsCancelButton(enable, animated: true)
        
        if !enable {
            searchBar.resignFirstResponder()
        }
    }
    
    // MARK: enableSearchTableView
    final func enableSearchTableView(_ tableView: UITableView, _ referenceView: UIView, enable: Bool = true) {
        tableView.isHidden = !enable
        tableView.snp.updateConstraints { make in
            if enable {
                make.height.equalTo(referenceView.frame.height)
            } else {
                make.height.equalTo(0)
            }
        }
    }
}

// MARK: - Public Function - Logic
extension HomeVM {
    // MARK: getForecast
    @objc final func getForecast(city: String) {
        guard let forecastUnit = globalSettings?.forecastUnit else {
            return
        }
        
        if city.count > 2 {
            let debouncedGetForecast = debounce(interval: 0, queue: .main) { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.getForecastUC(city.lowercased().trimmingCharacters(in: .whitespaces), forecastUnit).start()
            }
            
            DispatchQueue.global(qos: .background).async {
                debouncedGetForecast()
            }
        }
    }
    
    // MARK: getForecastByCoordinate
    final func getForecastByCoordinate() {
        guard let forecastUnit = globalSettings?.forecastUnit else {
            return
        }
        
        let request = LocationManager.shared.locateFromGPS(.oneShot, accuracy: .city) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .failure(let error):
                Log.error(error)
                /// Default is Ho Chi Minh
                self.getForecastByCoordinateUC(10.8333, 106.6667, forecastUnit).start()
                
            case .success(let location):
                let lat = Double(location.coordinate.latitude)
                let lon = Double(location.coordinate.longitude)
                
                self.getForecastByCoordinateUC(lat, lon, forecastUnit).start()
            }
        }
        
        request.start()
    }
}

// MARK: - Private Functions
extension HomeVM {
    // MARK: debounce
    final private func debounce(interval: Int, queue: DispatchQueue, action: @escaping (() -> Void)) -> () -> Void {
        var lastFireTime = DispatchTime.now()
        let dispatchDelay = DispatchTimeInterval.milliseconds(interval)

        return {
            lastFireTime = DispatchTime.now()
            let dispatchTime: DispatchTime = DispatchTime.now() + dispatchDelay

            queue.asyncAfter(deadline: dispatchTime) {
                let when: DispatchTime = lastFireTime + dispatchDelay
                let now = DispatchTime.now()
                if now.rawValue >= when.rawValue {
                    action()
                }
            }
        }
    }
}
