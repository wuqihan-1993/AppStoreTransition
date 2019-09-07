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
        
        
        let anim1 = CABasicAnimation(keyPath: "cornerRadius")
        anim1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        anim1.fromValue = 10
        anim1.toValue = 0
        anim1.duration = 0.8
        anim1.isRemovedOnCompletion = false
        snapshotView.bgImageView.layer.add(anim1, forKey: "cornerRadius")
        
        toVc.headerView.isHidden = true
        toVc.view.frame = cellNewRect
        toVc.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            
            self.snapshotView.updateAnimation()
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
        containerView.addSubview(toVc.view)
        containerView.addSubview(fromVc.view)
        containerView.addSubview(snapshotView)
        
        itemCell.isHidden = true
        
        self.snapshotView.frame = containerView.convert(fromVc.headerView.frame, from: fromVc.headerView.superview)
        
        let cellToRect = containerView.convert(itemCell.bgImageView.frame, from: itemCell.bgImageView.superview)
        fromVc.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            
            self.snapshotView.frame = cellToRect
            self.snapshotView.dismissAnimation()
            fromVc.view.frame = cellToRect
            fromVc.view.layoutIfNeeded()
//            containerView.layoutIfNeeded
            
            let tabBar = (UIApplication.shared.keyWindow?.rootViewController as! UITabBarController).tabBar
            tabBar.frame.origin.y = UIScreen.main.bounds.height - tabBar.bounds.height
            
        }) { (isComplete) in
            
//            self.snapshotView?.removeFromSuperview()
//            fromVc.view.removeFromSuperview()
            transitionContext.completeTransition(true)
            self.itemCell.isHidden = false
        }
       
    }
}

