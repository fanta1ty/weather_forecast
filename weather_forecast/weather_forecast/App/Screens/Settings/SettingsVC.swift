//
//  SettingsVC.swift
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

final class SettingsVC: BaseVC {
    // MARK: - UI Properties
    private let topView = ViewHelper(style: ViewStyle())
    private let topSeperateView = ViewHelper(style: ViewStyle(backgroundColor: .Alto))
    
    private let topTitleLb = LabelHelper(style: LabelStyle(textColor: .Black, textFont: .InterBold(size: 18), textAlignment: .center), text: "Settings")
    
    private let settingsTb = TableViewHelper(style: TableViewStyle(), cellClasses: [SettingsCell.self], cellIdentifiers: [SettingsCell.reuseIdentifier])
    
    // MARK: - Local Properties
    private let appStateStore: Store<AppState>
    let viewModel: SettingsVM
    private var disposeBag: DisposeBag?
    
    init(viewModel: SettingsVM) {
        self.viewModel = viewModel
        
        self.appStateStore = mainAssemblerResolver.resolve(Store.self)!
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        // MARK: settingsTb
        settingsTb.dataSource = self
        settingsTb.delegate = self
        view.addSubview(settingsTb)
        settingsTb.registerCells()
        
        settingsTb.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: setupRx
    override func setupRx() {
        disposeBag = DisposeBag()
    }
}

// MARK: - UITableViewDataSource
extension SettingsVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as? SettingsCell else {
            return SettingsCell(frame: .zero)
        }
        
        cell.loadData(data: viewModel.data[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return ViewHelper(style: ViewStyle())
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ViewHelper(style: ViewStyle())
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let controller = mainAssemblerResolver.resolve(ForecastUnitVC.self)!
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
            
        default:
            let controller = mainAssemblerResolver.resolve(CacheVC.self)!
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - Private Functions
extension SettingsVC {
}

// MARK: - UI Functions
extension SettingsVC {
    
}
