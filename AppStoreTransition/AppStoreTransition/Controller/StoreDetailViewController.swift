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
    
    private var isDismiss = false
    
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
        scrollView.bounces = false
        scrollView.delegate = self
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
        label.text = self.storeItem.content + self.storeItem.content 
        label.backgroundColor = UIColor.white
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
        
        view.backgroundColor = UIColor.orange
        setupUI()
        
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGestureAction(_:)))
        edgePanGesture.edges = UIRectEdge.left
        scrollView.addGestureRecognizer(edgePanGesture)
        
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
//        scrollView.addGestureRecognizer(panGesture)
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
        
        view.layer.masksToBounds = true
        view.contentMode = .center
        
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
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.top.equalTo(headerView.snp.bottom).offset(30)
        }

    }

}

extension StoreDetailViewController {
 
    @objc private func  edgePanGestureAction(_ edgePanGesture: UIScreenEdgePanGestureRecognizer) {
        let progress = edgePanGesture.translation(in: view).x / view.bounds.width
        let minScale: CGFloat = 0.83
        let scale = 1-progress*0.5
        if scale >= minScale {
        
            self.view.frame.size.width = UIScreen.main.bounds.width * scale
            self.view.frame.size.height = UIScreen.main.bounds.height * scale
            self.view.center = CGPoint(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.5)
            contentLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
            contentLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            let cornerRadius = (1.0-scale)/(1-minScale)*20
            self.view.layer.cornerRadius = cornerRadius
           
        }else {

            edgePanGesture.isEnabled = false
            isDismiss = true
            dismiss(animated: true, completion: nil)
            

            if isDismiss == false {
                
                isDismiss = true
                edgePanGesture.isEnabled = false
                self.view.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*minScale, height: UIScreen.main.bounds.height*minScale)
                self.view.center = CGPoint(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height*0.5)
                self.view.layoutIfNeeded()
                
                
                dismiss(animated: true) {
                    self.isDismiss = false
                }
            }
            return
        }
        
        switch edgePanGesture.state {
        case .began:
            break
        case .changed:
            break
        case .cancelled,.ended:
            if !isDismiss {
                print("CGAffineTransform.identity")
                UIView.animate(withDuration: 0.2) {
                    self.view.frame = UIScreen.main.bounds
                    self.contentLabel.transform = CGAffineTransform.identity
                }
            }else {
                print("dismiss")
                isDismiss = true
            }
        default:
            break
        }
        
    }
    
    @objc private func  panGestureAction(_ edgePanGesture: UIPanGestureRecognizer) {
        print(#function)
    }

    
}

extension StoreDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
    }
}
