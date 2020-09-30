//
//  HomeVC.swift
//  weather_forecast
//
//  Created by User on 3/9/20.
//  Copyright © 2020 Thinh Nguyen. All rights reserved.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import RxSwift
import ReSwift
import UIKit
import SVProgressHUD

final class HomeVC: UIViewController {
    // MARK: - UI Properties
    
    // MARK: - Local Properties
    private let appStateStore: Store<AppState>
    let viewModel: HomeVM
    private var disposeBag: DisposeBag?
    
    init(viewModel: HomeVM) {
        self.viewModel = viewModel
        
        self.appStateStore = mainAssemblerResolver.resolve(Store.self, name: CoreAssemblyType.Store.rawValue)!
        
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

        setupRx()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        disposeBag = nil
    }
}

// MARK: - Private Functions
extension HomeVC {
}

// MARK: - UI Functions
extension HomeVC {
    // MARK: setupUI
    private func setupUI() {
        view.backgroundColor = .white
    }
}

// MARK: - RX Functions
extension HomeVC {
    // MARK: setupRx
    final private func setupRx() {
        disposeBag = DisposeBag()
    }
}
