//
//  DetailHeaderView.swift
//  AppStoreTransition
//
//  Created by wuqh on 2019/9/5.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class StoreDetailHeaderView: UIView {
    
    var item: StoreItemModel! {
        didSet {
            titleLabel.text = item.title
            subTitleLabel.text = item.subTitle
            bgImageView.image = UIImage(named: item.imageName)
        }
    }
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bgImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bgImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bgImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 64).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        subTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
    
}
