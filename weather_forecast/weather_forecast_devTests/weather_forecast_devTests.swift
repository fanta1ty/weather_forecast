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
                return
                
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
    
    func testEnableSearchTableView() {
        let testTableView = UITableView()
        let viewModel = HomeVM()
        let testView = UIView()
        
        viewModel.enableSearchTableView(testTableView, testView, enable: false)
        XCTAssertEqual(testTableView.isHidden, true)
    }
    
    // MARK: - Settings
    func testSettingsEqualtable() {
        let settingsA = Settings(cacheLifeTime: 1, forecastUnit: .celsius)
        let settingsB = Settings(cacheLifeTime: 1, forecastUnit: .celsius)
        
        XCTAssertEqual(settingsA == settingsB, true)
    }
    
    func testSettingsNotEqualtable() {
        let settingsA = Settings(cacheLifeTime: 1, forecastUnit: .celsius)
        let settingsB = Settings(cacheLifeTime: 1, forecastUnit: .kelvin)
        
        XCTAssertEqual(settingsA == settingsB, false)
    }
    
    // MARK: - ErrorResponse
    func testErrorResponseEqualtable() {
        let errorResponseA = ErrorResponse(cod: "A", message: "B")
        let errorResponseB = ErrorResponse(cod: "A", message: "B")
        
        XCTAssertEqual(errorResponseA == errorResponseB, true)
    }
    
    func testErrorResponseNotEqualtable() {
        let errorResponseA = ErrorResponse(cod: "A1", message: "B")
        let errorResponseB = ErrorResponse(cod: "A2", message: "B")
        
        XCTAssertEqual(errorResponseA == errorResponseB, false)
    }
    
    // MARK: - Weather
    func testWeatherEqualtable() {
        let weatherA = Weather(id: 1, main: .ash, desc: nil, icon: nil, iconURL: nil)
        let weatherB = Weather(id: 1, main: .ash, desc: nil, icon: nil, iconURL: nil)
        
        XCTAssertEqual(weatherA == weatherB, true)
    }
    
    func testWeatherNotEqualtable() {
        let weatherA = Weather(id: 1, main: .ash, desc: nil, icon: nil, iconURL: nil)
        let weatherB = Weather(id: 2, main: .clouds, desc: nil, icon: nil, iconURL: nil)
        
        XCTAssertEqual(weatherA == weatherB, false)
    }
    
    // MARK: - FeelsLike
    func testFeelsLikeEqualtable() {
        let feelsLikeA = FeelsLike(day: 1, night: 2, eve: 3, morn: 4)
        let feelsLikeB = FeelsLike(day: 1, night: 2, eve: 3, morn: 4)
        
        XCTAssertEqual(feelsLikeA == feelsLikeB, true)
    }
    
    func testFeelsLikeNotEqualtable() {
        let feelsLikeA = FeelsLike(day: 1, night: 2, eve: 3, morn: 4)
        let feelsLikeB = FeelsLike(day: 4, night: 3, eve: 2, morn: 1)
        
        XCTAssertEqual(feelsLikeA == feelsLikeB, false)
    }
    
    // MARK: - Temperature
    func testTemperatureEqualtable() {
        let temperatureA = Temperature(day: 1, min: 2, max: 3, night: 4, eve: 5, morn: 6)
        let temperatureB = Temperature(day: 1, min: 2, max: 3, night: 4, eve: 5, morn: 6)
        
        XCTAssertEqual(temperatureA == temperatureB, true)
    }
    
    func testTemperatureNotEqualtable() {
        let temperatureA = Temperature(day: 1, min: 2, max: 3, night: 4, eve: 5, morn: 6)
        let temperatureB = Temperature(day: 6, min: 5, max: 4, night: 3, eve: 2, morn: 1)
        
        XCTAssertEqual(temperatureA == temperatureB, false)
    }
    
    // MARK: - City
    func testCityEqualtable() {
        let cityA = City(id: 1, name: "A", coord: nil, country: nil, population: nil, timezone: nil)
        let cityB = City(id: 1, name: "A", coord: nil, country: nil, population: nil, timezone: nil)
        
        XCTAssertEqual(cityA == cityB, true)
    }
    
    func testCityNotEqualtable() {
        let cityA = City(id: 1, name: "A", coord: nil, country: nil, population: nil, timezone: nil)
        let cityB = City(id: 2, name: "B", coord: nil, country: nil, population: nil, timezone: nil)
        
        XCTAssertEqual(cityA == cityB, false)
    }
    
    // MARK: - CityCoordinate
    func testCityCoordinateEqualtable() {
        let cityCoordinateA = CityCoordinate(lon: 1, lat: 1)
        let cityCoordinateB = CityCoordinate(lon: 1, lat: 1)
        
        XCTAssertEqual(cityCoordinateA == cityCoordinateB, true)
    }
    
    func testCityCoordinateNotEqualtable() {
        let cityCoordinateA = CityCoordinate(lon: 1, lat: 1)
        let cityCoordinateB = CityCoordinate(lon: 2, lat: 2)
        
        XCTAssertEqual(cityCoordinateA == cityCoordinateB, false)
    }
    
    // MARK: - ForecastItem
    func testForecastItemEqualtable() {
        let forecastItemA = ForecastItem(dt: 1, sunrise: 1, sunset: 1, temp: nil, feelsLike: nil, pressure: 1, humidity: 1, weather: nil, speed: 1, deg: 1, clouds: 1, pop: 1)
        let forecastItemB = ForecastItem(dt: 1, sunrise: 1, sunset: 1, temp: nil, feelsLike: nil, pressure: 1, humidity: 1, weather: nil, speed: 1, deg: 1, clouds: 1, pop: 1)
        
        XCTAssertEqual(forecastItemA == forecastItemB, true)
    }
    
    func testForecastItemNotEqualtable() {
        let forecastItemA = ForecastItem(dt: 1, sunrise: 1, sunset: 1, temp: nil, feelsLike: nil, pressure: 1, humidity: 1, weather: nil, speed: 1, deg: 1, clouds: 1, pop: 1)
        let forecastItemB = ForecastItem(dt: 2, sunrise: 1, sunset: 1, temp: nil, feelsLike: nil, pressure: 1, humidity: 1, weather: nil, speed: 1, deg: 1, clouds: 1, pop: 1)
        
        XCTAssertEqual(forecastItemA == forecastItemB, false)
    }
    
    // MARK: - Forecast
    func testForecastEqualtable() {
        let forecastA = Forecast(city: nil, cod: "1", message: nil, cnt: nil, list: nil)
        let forecastB = Forecast(city: nil, cod: "1", message: nil, cnt: nil, list: nil)
        
        XCTAssertEqual(forecastA == forecastB, true)
    }
    
    func testForecastNotEqualtable() {
        let forecastA = Forecast(city: nil, cod: "1", message: nil, cnt: nil, list: nil)
        let forecastB = Forecast(city: nil, cod: "2", message: nil, cnt: nil, list: nil)
        
        XCTAssertEqual(forecastA == forecastB, false)
    }
}
