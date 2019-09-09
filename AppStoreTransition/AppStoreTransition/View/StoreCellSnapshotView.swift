//
//  StoreCellSnapshotView.swift
//  AppStoreTransition
//
//  Created by wuqh on 2019/9/6.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit
import SnapKit

class StoreCellSnapshotView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: self.bounds.width - 36 - 30, y: 20, width: 36, height: 36)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.alpha = 0
        return button
    }()
    
    var titleLabelTopConstaint: NSLayoutConstraint?
    
    init(storeItem: StoreItemModel,frame: CGRect) {
        super.init(frame: frame)
        
        bgImageView.image = UIImage(named: storeItem.imageName)
        titleLabel.text = storeItem.title
        subTitleLabel.text = storeItem.subTitle
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(closeButton)
        
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
        }
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        closeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(36)
        }
    }
    
    func presentWillAnimated() {
        
        let anim1 = CABasicAnimation(keyPath: "cornerRadius")
        anim1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        anim1.fromValue = 10
        anim1.toValue = 0
        anim1.duration = 0.8
        anim1.isRemovedOnCompletion = false
        bgImageView.layer.add(anim1, forKey: "cornerRadius")
        
        self.snp.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width*1.45)
        }
        titleLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(64)
        }
        closeButton.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(64)
        }
        
        closeButton.alpha = 0
    }
    func presetnAnimated() {
        closeButton.alpha = 1
    }
    
    func dismissWillAnimated() {
        titleLabel.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(10)
        }
        closeButton.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(20)
        }
    }
    
    func dismissAnimated() {
        closeButton.alpha = 0
    }

}
