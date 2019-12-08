//
//  PopAnimation.swift
//  EventApp 1
//
//  Created by Vova SKR on 08/12/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.8
     var presenting = true
     var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    
}
