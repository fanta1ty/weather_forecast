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

final class HomeVM {
    // MARK: UC Properties
    let getForecastUC: ((String) -> GetForecastUC)!
    var searchs: [ForecastItem] = [ForecastItem]()
    
    init() {
        self.getForecastUC = { city in
            mainAssemblerResolver.resolve(GetForecastUC.self, argument: city)!
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
    final func getForecast(city: String) {
        getForecastUC(city.lowercased()).start()
    }
}
