//
//  CacheVC.swift
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

final class CacheVC: BaseVC {
    // MARK: - UI Properties
    private let topView = ViewHelper(style: ViewStyle())
    private let topSeperateView = ViewHelper(style: ViewStyle(backgroundColor: .Alto))
    private let lifeTimeView = ViewHelper(style: ViewStyle(borderColor: .Alto, borderWidth: 1, corderRadius: 4))
    
    private let topBackImageView = ImageViewHelper(style: ImageViewStyle(), iconImage: DefinedAssets.backIcon.rawValue.uiImage)
    
    private let topTitleLb = LabelHelper(style: LabelStyle(textColor: .Black, textFont: .InterBold(size: 18), textAlignment: .center), text: "Cache Settings")
    private let lifeTimeTitleLb = LabelHelper(style: LabelStyle(), text: "Cache life time (minutes):")
    
    private let lifeTimeTf = TextFieldHelper(style: TextFieldStyle(textAlignment: .right, keyboardType: .numberPad))
    
    private let topBackBtn = ButtonHelper(style: ButtonStyle())
    private let saveBtn = ButtonHelper(style: ButtonStyle(backgroundColor: .Cerulean, corderRadius: 4, textColor: .White, textFont: .InterBold(size: 18)), title: "Save")
    private let clearCacheBtn = ButtonHelper(style: ButtonStyle(backgroundColor: .Bordeaux, corderRadius: 4, textColor: .White, textFont: .InterBold(size: 18)), title: "Clear Cache")
    
    // MARK: - Local Properties
    private let appStateStore: Store<AppState>
    let viewModel: CacheVM
    private var disposeBag: DisposeBag?
    
    init(viewModel: CacheVM) {
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
        
        // MARK: lifeTimeTitleLb
        lifeTimeTitleLb.font = UIFont.preferredFont(forTextStyle: .body)
        lifeTimeTitleLb.adjustsFontForContentSizeCategory = true
        view.addSubview(lifeTimeTitleLb)
        
        lifeTimeTitleLb.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        // MARK: lifeTimeView
        view.addSubview(lifeTimeView)
        
        lifeTimeView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(lifeTimeTitleLb.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        
        // MARK: lifeTimeTf
        lifeTimeTf.delegate = self
        lifeTimeView.addSubview(lifeTimeTf)
        
        lifeTimeTf.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        // MARK: saveBtn
        saveBtn.addTarget(self, action: #selector(onSaveBtn(_:)), for: .touchUpInside)
        view.addSubview(saveBtn)
        
        saveBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
            make.top.equalTo(lifeTimeView.snp.bottom).offset(16)
        }
        
        // MARK: clearCacheBtn
        clearCacheBtn.addTarget(self, action: #selector(onClearCacheBtn(_:)), for: .touchUpInside)
        view.addSubview(clearCacheBtn)
        
        clearCacheBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
            make.top.equalTo(saveBtn.snp.bottom).offset(8)
        }
    }
    
    // MARK: setupRx
    override func setupRx() {
        disposeBag = DisposeBag()
    }
}

// MARK: - UITextFieldDelegate
extension CacheVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(nil)
    }
}

// MARK: - Private Functions
extension CacheVC {
    // MARK: loadData
    final private func loadData() {
        lifeTimeTf.text = globalSettings?.cacheLifeTime?.toString
    }
}

// MARK: - Action Functions
extension CacheVC {
    // MARK: onTopBackBtn
    @objc final private func onTopBackBtn(_ sender: UIButton?) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: onSaveBtn
    @objc final private func onSaveBtn(_ sender: UIButton?) {
        guard let lifeTimeStr = lifeTimeTf.text, lifeTimeStr.isEmpty == false else {
            return
        }
        
        globalSettings?.cacheLifeTime = lifeTimeStr.toInt()
        
        guard let globalSettings = globalSettings else {
            return
        }
        
        _ = viewModel.localSettingsDataStore.set(globalSettings).done { [weak self] in
            guard let self = self else {
                return
            }
            
            SVProgressHUD.showSuccess(withStatus: "Completed!")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {                SVProgressHUD.dismiss()
                self.onTopBackBtn(nil)
            }
        }
    }
    
    // MARK: onClearCacheBtn
    @objc final private func onClearCacheBtn(_ sender: UIButton?) {
        SVProgressHUD.showSuccess(withStatus: "Completed!")
        viewModel.cache.removeValue()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else {
                return
            }
            SVProgressHUD.dismiss()
            self.onTopBackBtn(nil)
        }
    }
}
