//
//  CustomPopAnimator.swift
//  L2_toroyanseda
//
//  Created by Seda on 28/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
   
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            guard let source = transitionContext.viewController(forKey: .from) else { return }
            guard let destination = transitionContext.viewController(forKey: .to) else { return }
            
            transitionContext.containerView.addSubview(destination.view)
            transitionContext.containerView.sendSubviewToBack(destination.view)
            
            destination.view.frame = source.view.frame
         
            UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                    delay: 0,
                                    options: .calculationModePaced,
                                    animations: {
                                      UIView.addKeyframe(withRelativeStartTime: 0,
                                                           relativeDuration: 0.4,
                                                           animations: {
                                                            let translation = CGAffineTransform(translationX: source.view.frame.width, y: 0)
                                                            let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                                            source.view.transform = translation.concatenating(scale)
                                                            source.view.transform = source.view.transform.rotated(by: 90)
                                        })
                                     UIView.addKeyframe(withRelativeStartTime: 0.4,
                                                           relativeDuration: 0.4,
                                                           animations: {
                                                            source.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)

                                        })
                                       UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                           relativeDuration: 0.75,
                                                           animations: {
                                                            destination.view.transform = .identity

                                        })
                                        
                                        
            }) { finished in
                if finished && !transitionContext.transitionWasCancelled {
                    source.removeFromParent()
                } else if transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
                transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)

                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        }
                                        
    

}
}

