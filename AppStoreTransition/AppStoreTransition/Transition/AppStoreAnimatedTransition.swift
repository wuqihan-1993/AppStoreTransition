//
//  AppStoreAnimatedTransition.swift
//  AppStoreTransition
//
//  Created by wuqh on 2019/9/5.
//  Copyright © 2019 吴启晗. All rights reserved.
//

import UIKit

class AppStoreAnimatedTransition: NSObject {
    
    var itemCell = StoreCell()
    
    var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    private var snapshotView:StoreCellSnapshotView!
    
    enum TransitionType {
        case show
        case dismiss
    }
    
    var transitionType: TransitionType = .show
    
}

extension AppStoreAnimatedTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transitionType {
        case .show:
            showAnimateTransition(using: transitionContext)
        case .dismiss:
            dismissAnimateTransition(using: transitionContext)
            break
        }
    }
}

extension AppStoreAnimatedTransition {
    private func showAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! StoreDetailViewController
        let fromVc = transitionContext.viewController(forKey: .from)
        
        let containerView = transitionContext.containerView
        
        let cellNewRect = containerView.convert(itemCell.bgImageView.frame, from: itemCell.bgImageView.superview)
        snapshotView = StoreCellSnapshotView(storeItem: itemCell.item, frame: cellNewRect)
        snapshotView.layer.masksToBounds = true
        containerView.addSubview(toVc.view)
        containerView.addSubview(snapshotView)
        snapshotView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(cellNewRect.origin.x)
            make.top.equalToSuperview().offset(cellNewRect.origin.y)
            make.width.equalTo(cellNewRect.width)
            make.height.equalTo(cellNewRect.height)
        }

        toVc.headerView.isHidden = true
        toVc.view.frame = cellNewRect
        toVc.view.layoutIfNeeded()
        containerView.layoutIfNeeded()
        
        self.snapshotView.presentWillAnimated()
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            
            self.snapshotView.layoutIfNeeded()
            containerView.layoutIfNeeded()
            self.snapshotView.presetnAnimated()
            let tabBar = (UIApplication.shared.keyWindow?.rootViewController as! UITabBarController).tabBar
            tabBar.frame.origin.y = UIScreen.main.bounds.height
            toVc.view.frame = UIScreen.main.bounds
            toVc.view.layoutIfNeeded()
            
        }) { (isComplete) in
            transitionContext.completeTransition(true)
            self.snapshotView.removeFromSuperview()
          
            toVc.headerView.isHidden = false
            containerView.insertSubview(fromVc!.view, belowSubview: toVc.view)
            let blur = UIBlurEffect(style: .light)
            let visualEffectView = UIVisualEffectView(effect: blur)
            visualEffectView.frame = fromVc!.view.bounds
            containerView.insertSubview(visualEffectView, aboveSubview: fromVc!.view)
            
        }
        
    }
    
    private func dismissAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVc = transitionContext.viewController(forKey: .from) as? StoreDetailViewController,
            let toVc = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(true)
            return
        }
        
        let containerView = transitionContext.containerView
        
        fromVc.headerView.isHidden = true
        itemCell.isHidden = true
        
        let snapshotViewCurrentRect = containerView.convert(fromVc.headerView.frame, from: fromVc.headerView.superview)
        let snapshotTargetRect = containerView.convert(itemCell.bgImageView.frame, from: itemCell.bgImageView.superview)
        
        containerView.addSubview(toVc.view)
        containerView.addSubview(fromVc.view)
        containerView.addSubview(snapshotView)
        
        snapshotView.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(snapshotViewCurrentRect.origin.y)
            make.left.equalToSuperview().offset(snapshotViewCurrentRect.origin.x)
            make.width.equalTo(snapshotViewCurrentRect.width)
            make.height.equalTo(snapshotViewCurrentRect.height)
        }
        
        containerView.layoutIfNeeded()
        
        snapshotView.dismissWillAnimated()
        snapshotView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(snapshotTargetRect.origin.x)
            make.top.equalToSuperview().offset(snapshotTargetRect.origin.y)
            make.height.equalTo(snapshotTargetRect.height)
            make.width.equalTo(snapshotTargetRect.width)
        }
    
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveLinear, animations: {
            
            containerView.layoutIfNeeded()
            self.snapshotView.dismissAnimated()
            
            self.snapshotView.subTitleLabel.transform = CGAffineTransform.identity
            self.snapshotView.titleLabel.transform = CGAffineTransform.identity
            
            fromVc.view.frame = snapshotTargetRect
            fromVc.view.layoutIfNeeded()
            
            let tabBar = (UIApplication.shared.keyWindow?.rootViewController as! UITabBarController).tabBar
            tabBar.frame.origin.y = UIScreen.main.bounds.height - tabBar.bounds.height
            
            
            
            
        }) { (isComplete) in
            transitionContext.completeTransition(true)
            self.itemCell.isHidden = false
        }
        
//        fromVc.headerView.isHidden = true
//        containerView.addSubview(toVc.view)
//        containerView.addSubview(fromVc.view)
//        containerView.addSubview(snapshotView)
//
//        itemCell.isHidden = true
//
//        let subTitleLabelFrame = self.snapshotView.subTitleLabel.frame
//        self.snapshotView.frame = containerView.convert(fromVc.headerView.frame, from: fromVc.headerView.superview)
//        self.snapshotView.subTitleLabel.frame = subTitleLabelFrame
//        self.snapshotView.layoutIfNeeded()
//        containerView.layoutIfNeeded()
//        let cellToRect = containerView.convert(itemCell.bgImageView.frame, from: itemCell.bgImageView.superview)
//        fromVc.view.layoutIfNeeded()
//
//        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: UIView.AnimationOptions.curveEaseInOut, animations: {
//
//            self.snapshotView.frame = cellToRect
//            self.snapshotView.dismissAnimation()
//            fromVc.view.frame = cellToRect
//            fromVc.view.layoutIfNeeded()
//
//
//            let tabBar = (UIApplication.shared.keyWindow?.rootViewController as! UITabBarController).tabBar
//            tabBar.frame.origin.y = UIScreen.main.bounds.height - tabBar.bounds.height
//
//        }) { (isComplete) in
//
//            transitionContext.completeTransition(true)
//            self.itemCell.isHidden = false
//        }
       
    }
}

