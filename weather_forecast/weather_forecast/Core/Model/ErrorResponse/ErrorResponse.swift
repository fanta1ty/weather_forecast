//
//  ErrorResponse.swift
//  weather_forecast
//
//  Created by User on 10/1/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
struct ErrorResponse: Codable {
    let cod: String?
    let message: String?
}

// MARK: - Equatable
extension ErrorResponse: Equatable {
    static func ==(lhs: ErrorResponse, rhs: ErrorResponse) -> Bool {
        return lhs.cod == rhs.cod && lhs.message == rhs.message
    }
}
