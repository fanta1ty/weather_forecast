//
//  AppDelegate.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Email: thinhnguyen12389@gmail.com
//

import UIKit
import Swinject
import IQKeyboardManagerSwift
import SVProgressHUD
import CoreLocation
import ReSwift
import Alamofire
import TSwiftHelper

// MARK: - Global Properties
let mainAssemblerResolver = AppDelegate.assembler.resolver
var APP_ID = ""

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private(set) static var assembler: Assembler = Assembler(AppAssembly.allAssemblies)
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        loadEnvironment()
        setupThirdPartyServices(launchOptions: launchOptions)
        launchStartPage()
        return true
    }
}

// MARK: - Private Functions
extension AppDelegate {
    final private func loadEnvironment() {
        switch environment {
        case .development:
            APP_ID = "60c6fbeb4b93ac653c492ba806fc346d"
            
        case .production:
            APP_ID = "60c6fbeb4b93ac653c492ba806fc346d"
        }
    }
    
    // MARK: setupThirdPartyServices
    final private func setupThirdPartyServices(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        // MARK: IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        
        // MARK: SVProgressHUD
        SVProgressHUD.setMaxSupportedWindowLevel(.alert)
        SVProgressHUD.setDefaultMaskType(.clear)
        
        // MARK: Load all fonts
        FontHelper.loadAll()
    }
    
    // MARK: Launch Start Page Function
    final private func launchStartPage() {
        window = UIWindow()
        
        let splashVC = mainAssemblerResolver.resolve(SplashVC.self)!
        
        let navigationController = UINavigationController(rootViewController: splashVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .black
        navigationBarAppearace.barTintColor = .white
    }
}

