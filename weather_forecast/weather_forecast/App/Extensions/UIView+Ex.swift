//
//  UIView+Ex.swift
//  weather_forecast
//
//  Created by User on 4/7/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        #if swift(>=3.2)
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
        #else
        return self.snp
        #endif
    }
}
