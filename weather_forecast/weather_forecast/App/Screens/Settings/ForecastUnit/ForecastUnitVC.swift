//
//  ForecastUnitVC.swift
//  weather_forecast
//
//  Created by User on 10/3/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import RxSwift
import ReSwift
import UIKit
import SVProgressHUD
import TSwiftHelper

final class ForecastUnitVC: BaseVC {
    // MARK: - UI Properties
    private let topView = ViewHelper(style: ViewStyle())
    private let topSeperateView = ViewHelper(style: ViewStyle(backgroundColor: .Alto))
    
    private let topBackImageView = ImageViewHelper(style: ImageViewStyle(), iconImage: DefinedAssets.backIcon.rawValue.uiImage)
    
    private let forecastUnitSegment = UISegmentedControl(items: ["Metric: ℃", "Imperial: ℉"])
    
    private let topTitleLb = LabelHelper(style: LabelStyle(textColor: .Black, textFont: .InterBold(size: 18), textAlignment: .center), text: "Forecast Unit Settings")
    
    private let topBackBtn = ButtonHelper(style: ButtonStyle())
    private let saveBtn = ButtonHelper(style: ButtonStyle(backgroundColor: .Cerulean, corderRadius: 4, textColor: .White, textFont: .InterBold(size: 18)), title: "Save")
    
    // MARK: - Local Properties
    private let appStateStore: Store<AppState>
    let viewModel: ForecastUnitVM
    private var disposeBag: DisposeBag?
    
    init(viewModel: ForecastUnitVM) {
        self.viewModel = viewModel
        
        self.appStateStore = mainAssemblerResolver.resolve(Store.self)!
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        disposeBag = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: setupUI
    override func setupUI() {
        view.backgroundColor = .white
        
        // MARK: topView
        view.addSubview(topView)
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.left.right.equalToSuperview()
        }
        
        // MARK: topTitleLb
        topTitleLb.font = UIFont.preferredFont(forTextStyle: .headline)
        topTitleLb.adjustsFontForContentSizeCategory = true
        topView.addSubview(topTitleLb)
        
        topTitleLb.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        // MARK: topSeperateView
        topView.addSubview(topSeperateView)
        
        topSeperateView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
            make.top.equalTo(topTitleLb.snp.bottom).offset(16)
        }
        
        // MARK: topBackImageView
        topView.addSubview(topBackImageView)
        
        topBackImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        // MARK: topBackImageView
        topBackBtn.addTarget(self, action: #selector(onTopBackBtn(_:)), for: .touchUpInside)
        topView.addSubview(topBackBtn)
        
        topBackBtn.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(50)
        }
        
        // MARK: forecastUnitSegment
        forecastUnitSegment.addTarget(self, action: #selector(onForecastSegmentValueChanged(_:)), for: .valueChanged)
        view.addSubview(forecastUnitSegment)
        
        forecastUnitSegment.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
    }
    
    // MARK: setupRx
    override func setupRx() {
        disposeBag = DisposeBag()
    }
}

// MARK: - Private Functions
extension ForecastUnitVC {
    // MARK: loadData
    final private func loadData() {
        switch globalSettings?.forecastUnit {
        case .celsius:
            forecastUnitSegment.selectedSegmentIndex = 0
        default:
            forecastUnitSegment.selectedSegmentIndex = 1
        }
    }
}

// MARK: - Action Functions
extension ForecastUnitVC {
    // MARK: onTopBackBtn
    @objc final private func onTopBackBtn(_ sender: UIButton?) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc final private func onForecastSegmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            globalSettings?.forecastUnit = .fahrenheit
            
        default:
            globalSettings?.forecastUnit = .celsius
        }
        
        guard let globalSettings = globalSettings else {
            return
        }
        
        _ = viewModel.localSettingsDataStore.set(globalSettings).done {
            
            SVProgressHUD.showSuccess(withStatus: "Completed!")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {                SVProgressHUD.dismiss()
            }
        }
    }
}
