//
//  SplashVC.swift
//  weather_forecast
//
//  Created by Thinh Nguyen on 9/30/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import RxSwift
import ReSwift
import UIKit
import SVProgressHUD
import TSwiftHelper
import SnapKit

final class SplashVC: BaseVC {
    // MARK: - UI Properties
    private let titleLb = LabelHelper(style: LabelStyle(textFont: .regular(size: 40), textAlignment: .center), text: "Weather Forecast")
    
    // MARK: - Local Properties
    private let appStateStore: Store<AppState>
    let viewModel: SplashVM
    private var disposeBag: DisposeBag?
    
    init(viewModel: SplashVM) {
        self.viewModel = viewModel
        
        self.appStateStore = mainAssemblerResolver.resolve(Store.self)!
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadLocalSetting()
        goToNextScreen()
    }
    
    override func setupUI() {
        view.backgroundColor = .white
        
        // MARK: titleLb
        view.addSubview(titleLb)
        
        titleLb.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
}

// MARK: - Private Functions
extension SplashVC {
    // MARK: goToNextScreen
    final private func goToNextScreen() {
        let controller = mainAssemblerResolver.resolve(MainTabbarVC.self)!
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UI Functions
extension SplashVC {
}

// MARK: - RX Functions
extension SplashVC {
}
