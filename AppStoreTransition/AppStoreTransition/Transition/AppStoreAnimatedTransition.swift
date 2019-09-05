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
        
        let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let containerView = transitionContext.containerView
        
        let newItemCell = itemCell.copeView()
        let cellNewRect = containerView.convert(itemCell.frame, from: itemCell.superview)
        newItemCell.frame = cellNewRect
        
        
//        newItemCell.frame = cellNewRect
        containerView.addSubview(toVc!.view)
        toVc?.view.alpha = 0
        containerView.addSubview(newItemCell)
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.curveLinear, animations: {
            newItemCell.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 1.45)
            toVc?.view.alpha = 1
        }) { (isComplete) in
            transitionContext.completeTransition(true)
            newItemCell.removeFromSuperview()
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
        let fromVc = transitionContext.viewController(forKey: .from)
        let toVc = transitionContext.viewController(forKey: .to)
        //        let containerView = transitionContext.containerView
        
        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0, animations: {
                toVc?.view.transform = CGAffineTransform.identity
                fromVc?.view.transform = CGAffineTransform.identity
            })
        }) { (_) in
            print("delete complete")
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
