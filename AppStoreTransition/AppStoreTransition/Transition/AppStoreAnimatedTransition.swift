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
            self.itemCell.transform = CGAffineTransform(scaleX: 1, y: 1)
            toVc.headerView.isHidden = false
        }
        
        
        
        

//        UIView.animateKeyframes(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIView.KeyframeAnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        
//        let width = UIScreen.main.bounds.size.width
//        let x = -width
//        toVc?.view.frame = CGRect(x: x, y: 0, width: containerView.bounds.width, height: containerView.bounds.height)
//        containerView.addSubview(toVc!.view)
//        containerView.addSubview(fromVc!.view)
//
//        let translationX = width
//        let t1 = CGAffineTransform(scaleX: 1, y: 1)
//        let t2 = CGAffineTransform(translationX: translationX, y: 0)
//        let fromVCTransform = t1.concatenating(t2)
//        let toVcTransform = CGAffineTransform(translationX: width, y: 0)
//        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: [], animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0, animations: {
//                fromVc!.view.transform = fromVCTransform
//                toVc!.view.transform = toVcTransform
//            })
//        }) { (_) in
//            // 当UIPercentDrivenInteractiveTransition调用cancel时，transitionWasCancelled= true (很重要)
//            if transitionContext.transitionWasCancelled {
//                transitionContext.completeTransition(false)
//            }else {
//                transitionContext.completeTransition(true)
//                containerView.addSubview(fromVc!.view)
//            }
//
//        }
        
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
        
        let cellToRect = containerView.convert(itemCell.bgImageView.frame, from: itemCell.bgImageView.superview)
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            
            self.snapshotView.frame = cellToRect
            self.snapshotView.dismissAnimation()
            fromVc.view.frame = cellToRect
            fromVc.view.layoutIfNeeded()
            
            let tabBar = (UIApplication.shared.keyWindow?.rootViewController as! UITabBarController).tabBar
            tabBar.frame.origin.y = UIScreen.main.bounds.height - tabBar.bounds.height
            
        }) { (isComplete) in
            
            transitionContext.completeTransition(true)
            self.itemCell.isHidden = false
        }
       
    }
}
