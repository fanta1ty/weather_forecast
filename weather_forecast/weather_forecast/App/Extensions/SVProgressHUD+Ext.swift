//
//  SVProgressHUD+Ext.swift
//  weather_forecast
//
//  Created by User on 4/7/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import SVProgressHUD

extension SVProgressHUD {
    open class func showInfo(_ status: String, maxTime: TimeInterval = 60) {
        SVProgressHUD.showInfo(withStatus: status)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + maxTime) {
            SVProgressHUD.dismiss()
        }
    }
    open class func show(_ status: String, maxTime: TimeInterval = 60) {
        SVProgressHUD.show(withStatus: status)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + maxTime) {
            SVProgressHUD.dismiss()
        }
    }
    
    open class func show(maxTime: TimeInterval = 60) {
        SVProgressHUD.show()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + maxTime) {
            SVProgressHUD.dismiss()
        }
    }
}
