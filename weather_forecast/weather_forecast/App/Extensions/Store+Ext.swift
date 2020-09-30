//
//  Store+Ext.swift
//  weather_forecast
//
//  Created by User on 4/7/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import ReSwift

extension Store {
    final func dispatchOnMain(action: Action) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.dispatch(action)
        }
    }
}
