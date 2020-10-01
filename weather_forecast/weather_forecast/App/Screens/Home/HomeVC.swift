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
import TSwiftHelper

final class HomeVC: BaseVC {
    enum TableViewType: Int {
        case search = 1, recentSearch = 2
    }
    
    // MARK: - UI Properties
    private let topView = ViewHelper(style: ViewStyle())
    private let contentView = ViewHelper(style: ViewStyle())
    
    private let topTitleLb = LabelHelper(style: LabelStyle(textColor: .Black, textFont: .InterBold(size: 18), textAlignment: .center), text: "Weather Forecast")
    
    private let searchBar = UISearchBar(frame: .zero)
    
    private let searchTb = TableViewHelper(style: TableViewStyle(), cellClasses: [SearchCell.self], cellIdentifiers: [SearchCell.reuseIdentifier])
    
    // MARK: - Local Properties
    private let appStateStore: Store<AppState>
    let viewModel: HomeVM
    private var disposeBag: DisposeBag?
    
    private let getForecastState: GetForecastObservable!
    
    init(viewModel: HomeVM) {
        self.viewModel = viewModel
        
        self.appStateStore = mainAssemblerResolver.resolve(Store.self)!
        
        self.getForecastState = mainAssemblerResolver.resolve(GetForecastObservable.self, name: ForecastStateType.GetForecast.rawValue)!
        
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
        topView.addSubview(topTitleLb)
        
        topTitleLb.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        // MARK: searchBar
        searchBar.delegate = self
        topView.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(topTitleLb.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        // MARK: contentView
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        // MARK: searchTb
        searchTb.dataSource = self
        searchTb.delegate = self
        searchTb.registerCells()
        searchTb.tag = TableViewType.search.rawValue
        contentView.addSubview(searchTb)
        
        searchTb.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(0)
        }
    }
    
    // MARK: setupRx
    override func setupRx() {
        disposeBag = DisposeBag()
        
        getForecastState.subscribe { [weak self] state in
            guard let self = self else {
                return
            }
            
            switch state {
            case .fail(_):
                SVProgressHUD.dismiss()
                self.viewModel.searchs.removeAll()
                self.searchTb.reloadData()
                
            case .result(let data):
                guard let data = data else {
                    return
                }
                SVProgressHUD.dismiss()
                
                if let list = data.list {
                    self.viewModel.searchs = list
                    self.searchTb.reloadData()
                }
            }
        } onDisposed: {
            Log.debug("Disposed success")
        }.disposed(by: disposeBag!)
    }
}

// MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView.tag {
        case TableViewType.search.rawValue:
            return 1
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case TableViewType.search.rawValue:
            return viewModel.searchs.count
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case TableViewType.search.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseIdentifier, for: indexPath) as? SearchCell else {
                return SearchCell(frame: .zero)
            }
            
            cell.loadData(data: viewModel.searchs[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeVC: UITableViewDelegate {
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
}

// MARK: - Private Functions
extension HomeVC {
}

// MARK: - UI Functions
extension HomeVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension HomeVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.enableSearchBar(searchBar, searchedText: searchBar.text)
        viewModel.enableSearchTableView(searchTb, contentView)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.enableSearchBar(searchBar, enable: false)
        viewModel.enableSearchTableView(searchTb, contentView, enable: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.enableSearchBar(searchBar, enable: false, searchedText: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Log.debug("searchBar Text: \(searchBar.text) - searchText: \(searchText)")
        viewModel.getForecast(city: searchText)
    }
}
