//
//  Log.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import SwiftyBeaver

typealias Log = SwiftyBeaver

func setupLogger() {
    // SwiftyBeaver logging
    let console = ConsoleDestination()
    console.format = "$DHH:mm:ss$d $C$L$c $M"
    console.minLevel = .verbose
    SwiftyBeaver.addDestination(console)
}

extension Log {
    static func debug(message: String) {
        let length = Float(message.count + 3) * 1.5
        let seperate = String(repeating: "-", count: Int(length))
        Log.debug("\(message) \n\(seperate)")
    }
    
    static func error(message: String) {
        let length = Float(message.count + 3) * 1.5
        let seperate = String(repeating: "-", count: Int(length))
        Log.error("\(message) \n\(seperate)")
    }
    
    static func verbose(message: String) {
        let length = Float(message.count + 3) * 1.5
        let seperate = String(repeating: "-", count: Int(length))
        Log.verbose("\(message) \n\(seperate)")
    }
}
