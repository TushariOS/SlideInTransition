//
//  SlideInTransition.swift
//  SlideInTransition
//
//  Created by Tushar on 25/09/19.
//  Copyright © 2019 Tushar. All rights reserved.
//

import UIKit

class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {

    var isPresenting = false
    var dimmingView = UIView()
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        

        let containerView = transitionContext.containerView

        dimmingView.backgroundColor = .black
        dimmingView.alpha = 0.0
        containerView.addSubview(dimmingView)
        dimmingView.frame = containerView.bounds

        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeight = toViewController.view.bounds.height
        
        if isPresenting {
            // Add menu view controller to container
            containerView.addSubview(toViewController.view)
            
            // Init frame off the screen
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        //Animation on screen
        let transfer = {
            self.dimmingView.alpha = 0.5
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        
        // Animation back of the screen
        
        let identity = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        
        // Animation of the transition
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations:  {
            self.isPresenting ? transfer() : identity()
        }) { (_) in
            transitionContext.completeTransition(!isCancelled)
        }
    }
}
