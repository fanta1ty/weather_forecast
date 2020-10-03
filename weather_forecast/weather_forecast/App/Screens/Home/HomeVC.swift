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
    private let scrollView = UIScrollView(frame: .zero)
    
    private let topView = ViewHelper(style: ViewStyle())
    private let contentView = ViewHelper(style: ViewStyle())
    private let dateView = ViewHelper(style: ViewStyle(backgroundColor: .Alto, corderRadius: 4))
    private let temperatureView = ViewHelper(style: ViewStyle(borderColor: .Alto, borderWidth: 1, corderRadius: 10))
    private let morningTempView = ViewHelper(style: ViewStyle())
    private let afternoonTempView = ViewHelper(style: ViewStyle())
    private let eveningTempView = ViewHelper(style: ViewStyle())
    private let nightTempView = ViewHelper(style: ViewStyle())
    
    private let topTitleLb = LabelHelper(style: LabelStyle(textColor: .Black, textFont: .InterBold(size: 18), textAlignment: .center), text: "Weather Forecast")
    private let cityNameLb = LabelHelper(style: LabelStyle(textColor: .Black, textFont: .InterBold(size: 24), textAlignment: .center))
    private let dateLb = LabelHelper(style: LabelStyle(textColor: .Black, textFont: .InterBold(size: 18), textAlignment: .center))
    private let weatherDescLb = LabelHelper(style: LabelStyle(textFont: .InterBold(size: 18), textAlignment: .center))
    private let temperatureLb = LabelHelper(style: LabelStyle(textFont: .InterRegular(size: 18), textAlignment: .center))
    private let morningTempTitleLb = LabelHelper(style: LabelStyle(textAlignment: .center), text: "Morning")
    private let morningTempLb = LabelHelper(style: LabelStyle(textAlignment: .center))
    private let afternoonTempTitleLb = LabelHelper(style: LabelStyle(textAlignment: .center), text: "Afternoon")
    private let afternoonTempLb = LabelHelper(style: LabelStyle(textAlignment: .center))
    private let eveningTempTitleLb = LabelHelper(style: LabelStyle(textAlignment: .center), text: "Evening")
    private let eveningTempLb = LabelHelper(style: LabelStyle(textAlignment: .center))
    private let nightTempTitleLb = LabelHelper(style: LabelStyle(textAlignment: .center), text: "Night")
    private let nightTempLb = LabelHelper(style: LabelStyle(textAlignment: .center))
    
    private let searchBar = UISearchBar(frame: .zero)
    
    private let weatherImageView = ImageViewHelper(style: ImageViewStyle())
    
    private let searchTb = TableViewHelper(style: TableViewStyle(backgroundColor: .White), cellClasses: [SearchCell.self], cellIdentifiers: [SearchCell.reuseIdentifier])
    
    // MARK: - Local Properties
    private let appStateStore: Store<AppState>
    let viewModel: HomeVM
    private var disposeBag: DisposeBag?
    
    private let getForecastState: GetForecastObservable!
    private let getForecastByCoordinateState: GetForecastByCoordinateObservable!
    
    init(viewModel: HomeVM) {
        self.viewModel = viewModel
        
        self.appStateStore = mainAssemblerResolver.resolve(Store.self)!
        
        self.getForecastState = mainAssemblerResolver.resolve(GetForecastObservable.self, name: ForecastStateType.GetForecast.rawValue)!
        
        self.getForecastByCoordinateState = mainAssemblerResolver.resolve(GetForecastByCoordinateObservable.self, name: ForecastStateType.GetForecastByCoordinate.rawValue)!
        
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
        
        viewModel.getForecastByCoordinate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.enableSearchBar(searchBar, enable: false)
        resetSearchTableView()
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
        
        // MARK: searchBar
        searchBar.delegate = self
        searchBar.isAccessibilityElement = true
        searchBar.accessibilityTraits = .searchField
        searchBar.accessibilityLabel = "Search Weather Forecast"
        topView.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(topTitleLb.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        // MARK: scrollView
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        // MARK: contentView
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        // MARK: dateView
        dateView.isHidden = true
        contentView.addSubview(dateView)
        
        dateView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        // MARK: dateLb
        dateView.addSubview(dateLb)
        
        dateLb.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        // MARK: cityNameLb
        contentView.addSubview(cityNameLb)
        
        cityNameLb.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(dateView.snp.bottom).offset(16)
        }
        
        // MARK: weatherImageView
        contentView.addSubview(weatherImageView)
        
        weatherImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityNameLb.snp.bottom).offset(16)
            make.width.equalToSuperview().dividedBy(4)
            make.height.equalTo(weatherImageView.snp.width)
        }
        
        // MARK: weatherDescLb
        contentView.addSubview(weatherDescLb)
        
        weatherDescLb.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(weatherImageView.snp.bottom).offset(4)
        }
        
        // MARK: temperatureLb
        contentView.addSubview(temperatureLb)
        
        temperatureLb.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(weatherDescLb.snp.bottom).offset(8)
        }
        
        // MARK: temperatureView
        temperatureView.isHidden = true
        contentView.addSubview(temperatureView)
        
        temperatureView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(temperatureLb.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        // MARK: morningTempView
        temperatureView.addSubview(morningTempView)
        
        morningTempView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(4)
        }
        
        // MARK: morningTempTitleLb
        morningTempView.addSubview(morningTempTitleLb)
        
        morningTempTitleLb.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        
        // MARK: morningTempLb
        morningTempView.addSubview(morningTempLb)
        
        morningTempLb.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(morningTempTitleLb.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        // MARK: afternoonTempView
        temperatureView.addSubview(afternoonTempView)
        
        afternoonTempView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(morningTempView.snp.right)
            make.width.equalTo(morningTempView.snp.width)
        }
        
        // MARK: afternoonTempTitleLb
        afternoonTempView.addSubview(afternoonTempTitleLb)
        
        afternoonTempTitleLb.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        
        // MARK: afternoonTempLb
        afternoonTempView.addSubview(afternoonTempLb)
        
        afternoonTempLb.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(afternoonTempTitleLb.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        // MARK: eveningTempView
        temperatureView.addSubview(eveningTempView)
        
        eveningTempView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(afternoonTempView.snp.right)
            make.width.equalTo(morningTempView.snp.width)
        }
        
        // MARK: eveningTempTitleLb
        eveningTempView.addSubview(eveningTempTitleLb)
        
        eveningTempTitleLb.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        
        // MARK: eveningTempLb
        eveningTempView.addSubview(eveningTempLb)
        
        eveningTempLb.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(eveningTempTitleLb.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        // MARK: nightTempView
        temperatureView.addSubview(nightTempView)
        
        nightTempView.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(eveningTempView.snp.right)
        }
        
        // MARK: nightTempTitleLb
        nightTempView.addSubview(nightTempTitleLb)
        
        nightTempTitleLb.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }
        
        // MARK: nightTempLb
        nightTempView.addSubview(nightTempLb)
        
        nightTempLb.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(nightTempTitleLb.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        // MARK: searchTb
        searchTb.dataSource = self
        searchTb.delegate = self
        searchTb.registerCells()
        searchTb.tag = TableViewType.search.rawValue
        view.addSubview(searchTb)
        
        searchTb.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(0)
        }
    }
    
    // MARK: setupRx
    override func setupRx() {
        disposeBag = DisposeBag()
        
        // MARK: getForecastByCoordinateState
        getForecastByCoordinateState.subscribe { [weak self] state in
            guard let self = self else {
                return
            }
            
            switch state {
            case .fail(_):
                SVProgressHUD.dismiss()
                
            case .result(let data):
                guard let data = data else {
                    return
                }
                SVProgressHUD.dismiss()
                
                self.viewModel.currentForecast = data
                self.viewModel.currentForecastItem = data.list?.first
                self.loadData()
            }
        } onDisposed: {
            Log.debug("Disposed success")
        }.disposed(by: disposeBag!)
        
        // MARK: getForecastState
        getForecastState.subscribe { [weak self] state in
            guard let self = self else {
                return
            }
            
            switch state {
            case .fail(_):
                SVProgressHUD.dismiss()
                self.resetSearchTableView()
                
            case .result(let data):
                guard let data = data else {
                    return
                }
                SVProgressHUD.dismiss()
                
                self.viewModel.responsedForecast = data
                
                if self.viewModel.allowRefreshData {
                    self.viewModel.currentForecast = data
                    self.viewModel.allowRefreshData = false
                }
                
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
        let headerTb = ViewHelper(style: ViewStyle(backgroundColor: .White))
        
        let forecastSegment = UISegmentedControl(items: viewModel.forecastUnits)
        forecastSegment.addTarget(self, action: #selector(onForecastSegmentValueChanged(_:)), for: .valueChanged)
        headerTb.addSubview(forecastSegment)
        
        forecastSegment.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
        }
        
        switch globalSettings?.forecastUnit {
        case .celsius:
            forecastSegment.selectedSegmentIndex = 0
        default:
            forecastSegment.selectedSegmentIndex = 1
        }
        
        return headerTb
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.searchs[indexPath.row]
        viewModel.currentForecastItem = item
        viewModel.currentForecast = viewModel.responsedForecast
        loadData()
        
        viewModel.enableSearchBar(searchBar, enable: false, searchedText: searchBar.text)
        viewModel.enableSearchTableView(searchTb, scrollView, enable: false)
    }
}

// MARK: - Private Functions
extension HomeVC {
    // MARK: resetSearchTableView
    final private func resetSearchTableView() {
        self.viewModel.searchs.removeAll()
        self.searchTb.reloadData()
    }
    
    // MARK: loadData
    final private func loadData() {
        guard let data = viewModel.currentForecastItem else {
            return
        }
        
        dateView.isHidden = false
        
        if let dateTime = data.dt {
            dateLb.text = Date(timeIntervalSince1970: dateTime).toString(format: "EE, dd MMM yyyy")
        }
        
        if let weather = data.weather?.first {
            if let iconURL = weather.iconURL {
                weatherImageView.image(url: iconURL)
            }
            
            if let main = weather.main {
                weatherImageView.accessibilityValue = "The Weather is \(main.rawValue)"
            }
        }
        
        if let desc = data.weather?.first?.desc {
            weatherDescLb.text = desc.capitalizedFirst()
        }
        
        var tempStr = ""
        var unitStr = ""
        
        if let forecastUnit = globalSettings?.forecastUnit {
            unitStr = forecastUnit.unitText
        }
        
        if let tempMax = data.temp?.max {
            tempStr += "The high will be " + tempMax.clean + unitStr
        }
        
        if let tempMin = data.temp?.min {
            tempStr += ", the low will be " + tempMin.clean + unitStr
        }
        
        temperatureLb.text = tempStr
        
        temperatureView.isHidden = false
        
        if let morn = data.temp?.morn {
            morningTempLb.text = morn.clean + unitStr
        }
        
        if let max = data.temp?.max {
            afternoonTempLb.text = max.clean + unitStr
        }
        
        if let eve = data.temp?.eve {
            eveningTempLb.text = eve.clean + unitStr
        }
        
        if let night = data.temp?.night {
            nightTempLb.text = night.clean + unitStr
        }
        
        guard let dataForecast = viewModel.currentForecast else {
            return
        }
        
        cityNameLb.text = dataForecast.city?.name
    }
}

// MARK: - Action Functions
extension HomeVC {
    // MARK: onForecastSegmentValueChanged
    @objc final private func onForecastSegmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            globalSettings?.forecastUnit = .fahrenheit
            
        default:
            globalSettings?.forecastUnit = .celsius
        }
        
        if let searchText = searchBar.text, searchText.isEmpty == false {
            viewModel.cache.removeValue()
            viewModel.getForecast(city: searchText)
        }
    }
}

// MARK: - UISearchBarDelegate
extension HomeVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.enableSearchBar(searchBar, searchedText: searchBar.text)
        viewModel.enableSearchTableView(searchTb, scrollView)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.enableSearchBar(searchBar, enable: false)
        viewModel.enableSearchTableView(searchTb, scrollView, enable: false)
        resetSearchTableView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.enableSearchBar(searchBar, enable: false, searchedText: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Log.debug("searchBar Text: \(searchBar.text) - searchText: \(searchText)")
        viewModel.getForecast(city: searchText)
    }
}
