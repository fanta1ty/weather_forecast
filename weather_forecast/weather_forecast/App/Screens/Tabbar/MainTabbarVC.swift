//
//  MainTabbarVC.swift
//  weather_forecast
//
//  Created by User on 3/9/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import UIKit
import ReSwift
import RxSwift
import SVProgressHUD
import PromiseKit

final class MainTabbarVC: UITabBarController {
    // MARK: Local Properties
    private let appStateStore: Store<AppState>
    private var disposeBag: DisposeBag?
    let viewModel: MainTabbarVM
    
    init(viewModel: MainTabbarVM) {
        self.appStateStore = mainAssemblerResolver.resolve(Store.self)!
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        for item in tabBar.items! {
            item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal)
            item.image = item.image?.withRenderingMode(.alwaysOriginal)
        }
    }
}

// MARK: - Private Functions
extension MainTabbarVC {
    // MARK: Implement Setup UI Function
    private func setupUI() {
        tabBar.barTintColor = .white
        
        // Init All Children View Controllers
        let homeVC = mainAssemblerResolver.resolve(HomeVC.self)!
        homeVC.tabBarItem = UITabBarItem(title: "Home".localized, image: DefinedAssets.homeTab.rawValue.uiImage, selectedImage: DefinedAssets.selectedHomeTab.rawValue.uiImage)
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.setNavigationBarHidden(true, animated: false)
        
        let settingsVC = mainAssemblerResolver.resolve(SettingsVC.self)!
        settingsVC.tabBarItem = UITabBarItem(title: "Setting".localized, image: DefinedAssets.settingsTab.rawValue.uiImage, selectedImage: DefinedAssets.selectedSettingsTab.rawValue.uiImage)
        let settingNav = UINavigationController(rootViewController: settingsVC)
        settingNav.setNavigationBarHidden(true, animated: false)
        
        viewControllers = [homeNav, settingNav]
    }
}
