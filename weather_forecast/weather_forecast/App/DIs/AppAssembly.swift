//
//  AppAssembly.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import Swinject
import SVProgressHUD
import ReSwift
import RxSwift

let environment = AppEnvironment(rawValue: Bundle.main.object(forInfoDictionaryKey: "ENV") as! String)!

final class AppAssembly {
    // MARK: - Properties
    static var allAssemblies: [Assembly] {
        var assemblies: [Assembly] = [AppAssembly(), CoreAssembly(), UseCaseAssembly(), StateAssembly()]
        
        switch environment {
        case .development:
            assemblies.append(APIAssembly(server: .development))
            
        default:
            assemblies.append(APIAssembly(server: .production))
        }
        
        return assemblies
    }
}

// MARK: - Assembly
extension AppAssembly: Assembly {
    func assemble(container: Container) {
        SVProgressHUD.setHapticsEnabled(true)
        
        // MARK: SplashVC
        container.register(SplashVC.self) { r in
            SplashVC(viewModel: SplashVM())
        }
        
        // MARK: MainTabbarVC
        container.register(MainTabbarVC.self) { r in
            MainTabbarVC(viewModel: MainTabbarVM())
        }
        
        // MARK: - HomeVC
        container.register(HomeVC.self) { r in
            HomeVC(viewModel: HomeVM())
        }
        
        // MARK: - SettingsVC
        container.register(SettingsVC.self) { r in
            SettingsVC(viewModel: SettingsVM())
        }
        
        // MARK: CacheVC
        container.register(CacheVC.self) { r in
            CacheVC(viewModel: CacheVM())
        }
    }
}
