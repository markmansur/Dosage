//
//  SlideInPresentationController.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-07.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
    private var dimmingView: UIView?
    
    override var frameOfPresentedViewInContainerView: CGRect {
      //1
      var frame: CGRect = .zero
      frame.size = size(forChildContentContainer: presentedViewController,
                        withParentContainerSize: containerView!.bounds.size)
        
        
        frame.origin.y = containerView!.frame.height*(1.0/4.0)
      
      
      return frame
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
      guard let dimmingView = dimmingView else { return }
      guard let containerView = containerView else { return }
      
      containerView.insertSubview(dimmingView, at: 0)
      
      dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
      dimmingView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
      dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
      dimmingView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
      
      guard let coordinator = presentedViewController.transitionCoordinator else {
        dimmingView.alpha = 1.0
        return
      }

      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView?.alpha = 1.0
      })
      
    }
    
    override func dismissalTransitionWillBegin() {
      guard let coordinator = presentedViewController.transitionCoordinator else {
        dimmingView?.alpha = 0.0
        return
      }

      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView?.alpha = 0.0
      })
    }
    
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height*(3.0/4.0))
    }
}

private extension SlideInPresentationController {
  func setupDimmingView() {
    dimmingView = UIView()
    dimmingView?.translatesAutoresizingMaskIntoConstraints = false
    dimmingView?.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    dimmingView?.alpha = 0.0
    
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
    dimmingView?.addGestureRecognizer(recognizer)
  }
  
  @objc func handleTap(recognizer: UITapGestureRecognizer) {
    presentingViewController.dismiss(animated: true, completion: nil)
  }
}
