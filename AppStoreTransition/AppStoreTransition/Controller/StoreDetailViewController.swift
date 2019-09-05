//
//  DetailViewController.swift
//  AppStoreTransition
//
//  Created by wuqh on 2019/9/5.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class StoreDetailViewController: UIViewController {
    
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
        return scrollView
    }()
    
    private lazy var headerView: StoreDetailHeaderView = {
        let headerView = StoreDetailHeaderView()
        headerView.item = self.storeItem
        return headerView
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = self.storeItem.content
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
        
        view.backgroundColor = UIColor.white
        setupUI()
        
    }
    
    @objc private func closeButtonClick() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupUI() {
    
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        scrollView.addSubview(headerView)
        scrollView.addSubview(contentLabel)
        scrollView.addSubview(contentLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*1.45).isActive = true
        headerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 36).isActive = true
        contentLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -36).isActive = true
        
    }


}
