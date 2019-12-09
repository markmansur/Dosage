//
//  SlideInPresentationManager.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-07.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class SlideInPresentationManager:NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SlideInPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
