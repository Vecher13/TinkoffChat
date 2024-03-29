//
//  TransitionManager.swift
//  Tinkoff first app
//
//  Created by Ash on 29.04.2021.
//

import UIKit

class TransitionManager: UIStoryboardSegue {
    override func perform() {
        scale()
    }

    func scale() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalCenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { _ in
            fromViewController.present(toViewController, animated: false, completion: nil)
        })
    }
    
}
