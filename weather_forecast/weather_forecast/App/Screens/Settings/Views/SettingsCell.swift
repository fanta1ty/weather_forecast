//
//  SettingsCell.swift
//  weather_forecast
//
//  Created by User on 10/3/20.
//  Email: thinhnguyen12389@gmail.com
//

import Foundation
import UIKit
import TSwiftHelper

final class SettingsCell: UITableViewCell {
    // MARK: UI Properties
    private let containerView = ViewHelper(style: ViewStyle())
    private let seperateView = ViewHelper(style: ViewStyle(backgroundColor: .Alto))
    
    private let settingLb = LabelHelper(style: LabelStyle())
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
}

// MARK: - Public Functions
extension SettingsCell {
    // MARK: loadData
    final func loadData(data: [String: String]?) {
        guard let data = data else {
            return
        }
        
        settingLb.text = data["name"]
        settingLb.accessibilityValue = data["name"]
    }
}

// MARK: - Action Functions
extension SettingsCell {
    
}

// MARK: - Private Functions
extension SettingsCell {
    
}

// MARK: - UI Functions
extension SettingsCell {
    // MARK: setupUI
    final private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        // MARK: containerView
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // MARK: settingLb
        settingLb.font = UIFont.preferredFont(forTextStyle: .body)
        settingLb.adjustsFontForContentSizeCategory = true
        containerView.addSubview(settingLb)
        
        settingLb.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        // MARK: seperateView
        containerView.addSubview(seperateView)
        
        seperateView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
            make.top.equalTo(settingLb.snp.bottom).offset(16)
        }
    }
}

