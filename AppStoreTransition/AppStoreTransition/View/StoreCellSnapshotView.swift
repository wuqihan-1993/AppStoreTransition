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
        let imageView = UIImageView(frame: self.bounds)
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 36*0.9)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.frame.origin = CGPoint(x: 20, y: 10)
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: self.bounds.height-21.5-20, width: 0, height: 0))
        label.font = UIFont.boldSystemFont(ofSize: 18*0.9)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.autoresizingMask = [UIView.AutoresizingMask.flexibleTopMargin,UIView.AutoresizingMask.flexibleLeftMargin]
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
        titleLabel.sizeToFit()
        subTitleLabel.text = storeItem.subTitle
        subTitleLabel.sizeToFit()
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
    }
    
    func updateAnimation() {
        frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 1.45)
        let fontSize: CGFloat = 36
        let currentFontSize: CGFloat = titleLabel.font.pointSize
        titleLabel.transform = CGAffineTransform(scaleX: fontSize/currentFontSize, y: fontSize/currentFontSize)
        titleLabel.frame.origin = CGPoint(x: 20, y: 64)
        
        let subTitleFont: CGFloat = 18
        let currentSubTitleFont: CGFloat = subTitleLabel.font.pointSize
        subTitleLabel.transform = CGAffineTransform(scaleX: subTitleFont/currentSubTitleFont, y: subTitleFont/currentSubTitleFont)
        subTitleLabel.frame.origin = CGPoint(x: 20, y: bounds.height-20-21.5)
        closeButton.frame.origin = CGPoint(x: bounds.width-36-20, y: 64)
        closeButton.alpha = 1
    }
    
    func dismissAnimation() {
        closeButton.alpha = 0
        closeButton.frame.origin = CGPoint(x: bounds.width-36-20, y: 20)
        titleLabel.frame.origin = CGPoint(x: 20, y: 10)
        subTitleLabel.frame.origin = CGPoint(x: 20, y: bounds.height-20-21.5)
    }

}
