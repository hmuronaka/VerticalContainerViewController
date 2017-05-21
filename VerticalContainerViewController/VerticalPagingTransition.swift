//
//  VerticalPagingTransition.swift
//  VerticalContainerViewController
//
//  Created by Muronaka Hiroaki on 2017/05/21.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

class VerticalPagingTransition: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    public fileprivate(set) var duration:TimeInterval
    
    public init(duration: TimeInterval = 0.5) {
        self.duration = duration
    }
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let toViewControllerFinalFrame = transitionContext.finalFrame(for: toViewController!)
        
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        let containerView = transitionContext.containerView
        
        toView.frame.origin.y = fromView.frame.height
        
        containerView.addSubview(toView)
        UIView.animate(withDuration: duration, animations: {
            toView.frame = toViewControllerFinalFrame
            fromView.frame.origin.y = -fromView.frame.height
        }) { isFinish in
            if isFinish {
                fromView.alpha = 1.0
                transitionContext.completeTransition(true)
            }
        }
    }
}
