//
//  SearchCell.swift
//  weather_forecast
//
//  Created by User on 10/1/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import UIKit
import TSwiftHelper

final class SearchCell: UITableViewCell {
    // MARK: UI Properties
    private let containerView = ViewHelper(style: ViewStyle())
    private let seperateView = ViewHelper(style: ViewStyle(backgroundColor: .Silver))
    
    private let dateLb = LabelHelper(style: LabelStyle())
    private let avgTempLb = LabelHelper(style: LabelStyle())
    private let pressureLb = LabelHelper(style: LabelStyle())
    private let humidityLb = LabelHelper(style: LabelStyle())
    private let descLb = LabelHelper(style: LabelStyle())
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
}

// MARK: - Public Functions
extension SearchCell {
    // MARK: loadData
    final func loadData(data: ForecastItem?) {
        guard let data = data else {
            return
        }
        
        var dateStr = "Date: ".localized
        
        if let dateTime = data.dt {
            dateStr += Date(timeIntervalSince1970: dateTime).toString(format: "E, dd MMM yyyy")
        }
        dateLb.text = dateStr
        
        var avgTempStr = "Average Temperature: ".localized
        avgTempLb.text = avgTempStr
        
        var pressureStr = "Pressure: ".localized
        
        if let pressure = data.pressure {
            pressureStr += pressure.clean
        }
        pressureLb.text = pressureStr
        
        var humidityStr = "Humidity: ".localized
        
        if let humidity = data.humidity {
            humidityStr += humidity.clean + "%"
        }
        humidityLb.text = humidityStr
        
        var descStr = "Description: ".localized
        if let desc = data.weather?.first?.desc {
            descStr += desc
        }
        descLb.text = descStr
    }
}

// MARK: - Action Functions
extension SearchCell {
    
}

// MARK: - Private Functions
extension SearchCell {
    
}

// MARK: - UI Functions
extension SearchCell {
    // MARK: setupUI
    final private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        // MARK: containerView
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // MARK: dateLb
        containerView.addSubview(dateLb)
        
        dateLb.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        // MARK: avgTempLb
        containerView.addSubview(avgTempLb)
        
        avgTempLb.snp.makeConstraints { make in
            make.top.equalTo(dateLb.snp.bottom).offset(8)
            make.left.right.equalTo(dateLb)
        }
        
        // MARK: pressureLb
        containerView.addSubview(pressureLb)
        
        pressureLb.snp.makeConstraints { make in
            make.top.equalTo(avgTempLb.snp.bottom).offset(8)
            make.left.right.equalTo(dateLb)
        }
        
        // MARK: humidityLb
        containerView.addSubview(humidityLb)
        
        humidityLb.snp.makeConstraints { make in
            make.top.equalTo(pressureLb.snp.bottom).offset(8)
            make.left.right.equalTo(dateLb)
        }
        
        // MARK: descLb
        containerView.addSubview(descLb)
        
        descLb.snp.makeConstraints { make in
            make.top.equalTo(humidityLb.snp.bottom).offset(8)
            make.left.right.equalTo(dateLb)
        }
        
        // MARK: seperateView
        containerView.addSubview(seperateView)
        
        seperateView.snp.makeConstraints { make in
            make.left.right.equalTo(dateLb)
            make.height.equalTo(1)
            make.top.equalTo(descLb.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}

