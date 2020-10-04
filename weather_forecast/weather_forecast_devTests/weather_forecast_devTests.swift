//
//  weather_forecast_devTests.swift
//  weather_forecast_devTests
//
//  Created by User on 10/4/20.
//

import XCTest
import RxSwift
import RxCocoa
@testable import weather_forecast_dev

class weather_forecast_devTests: XCTestCase {
    override class func setUp() {
    }
    
    override class func tearDown() {
    }

    func testGetForecastSuccess() {
        var isSuccess = false
        let expectation = self.expectation(description: "testSuccess")
        
        let getForecastState: GetForecastObservable = mainAssemblerResolver.resolve(GetForecastObservable.self, name: ForecastStateType.GetForecast.rawValue)!
        
        _ = getForecastState.subscribe(onNext: { state in
            switch state {
            case .fail(_):
                break
                
            case .result(let data):
                guard data != nil else {
                    return
                }
                isSuccess = true
                expectation.fulfill()
            }
        })
        
        let getForecastUC: ((String, ForecastUnit) -> GetForecastUC) = { city, unit in
            mainAssemblerResolver.resolve(GetForecastUC.self, arguments: city, unit)!
        }
        
        getForecastUC("saigon", .celsius).start()
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(isSuccess, true)
    }
    
    func testGetForecastFailed() {
        let isSuccess = false
        let expectation = self.expectation(description: "testFailed")
        
        let getForecastState: GetForecastObservable = mainAssemblerResolver.resolve(GetForecastObservable.self, name: ForecastStateType.GetForecast.rawValue)!
        
        _ = getForecastState.subscribe(onNext: { state in
            switch state {
            case .fail(_):
                expectation.fulfill()
                
            case .result(_):
                break
            }
        })
        
        let getForecastUC: ((String, ForecastUnit) -> GetForecastUC) = { city, unit in
            mainAssemblerResolver.resolve(GetForecastUC.self, arguments: city, unit)!
        }
        
        getForecastUC("XXX", .celsius).start()
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(isSuccess, false)
    }
    
    func testGetForecastByCoordinateSuccess() {
        var isSuccess = false
        let expectation = self.expectation(description: "testCoordinateSuccess")
        
        let getForecastByCoordinateState: GetForecastByCoordinateObservable = mainAssemblerResolver.resolve(GetForecastByCoordinateObservable.self, name: ForecastStateType.GetForecastByCoordinate.rawValue)!
        
        _ = getForecastByCoordinateState.subscribe(onNext: { state in
            switch state {
            case .fail(_):
                break
                
            case .result(let data):
                guard data != nil else {
                    return
                }
                isSuccess = true
                expectation.fulfill()
            }
        })
        
        let getForecastByCoordinateUC: ((Double, Double, ForecastUnit) -> GetForecastByCoordinateUC) = { lat, lon, unit in
            mainAssemblerResolver.resolve(GetForecastByCoordinateUC.self, arguments: lat, lon, unit)!
        }
        
        getForecastByCoordinateUC(37.785834, -122.406417, .celsius).start()
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(isSuccess, true)
    }
}
