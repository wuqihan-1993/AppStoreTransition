//
//  CustomTableViewCell.swift
//  AppStoreTransition
//
//  Created by wuqh on 2019/9/5.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var index: Int = 0 {
        didSet {
            bgImageView.image = UIImage(named: "image\(index)")
            titleLabel.text = "\(index).titletitletitletitletitletitle"
            subTitleLabel.text = "\(index).subTitlesubTitlesubTitlesubTitlesubTitle"
        }
    }
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.layer.cornerRadius = 10
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var frame = contentView.frame
        frame.size.width = frame.size.width*0.9
        frame.origin.x = center.x - (frame.size.width/2)
        contentView.frame = frame
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(bgImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bgImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bgImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true

        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        subTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }

}
