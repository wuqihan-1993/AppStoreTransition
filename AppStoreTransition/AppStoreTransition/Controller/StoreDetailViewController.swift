//
//  DetailViewController.swift
//  AppStoreTransition
//
//  Created by wuqh on 2019/9/5.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class StoreDetailViewController: UIViewController {
    
    var statusBarHidden = false {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    private let storeItem: StoreItemModel
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonClick), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    lazy var headerView: StoreDetailHeaderView = {
        let headerView = StoreDetailHeaderView(frame: CGRect.zero)
        headerView.item = self.storeItem
        return headerView
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = self.storeItem.content
        label.backgroundColor = UIColor.white
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.contentMode = .center
        
        return label
    }()
    
    init(storeItem: StoreItemModel) {
        self.storeItem = storeItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
    
    @objc private func closeButtonClick() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupUI() {
        
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        scrollView.addSubview(headerView)
        scrollView.addSubview(contentLabel)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(36)
        }
        
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(headerView.snp.width).multipliedBy(1.45)
            make.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom).offset(30)
        }

    }

}
