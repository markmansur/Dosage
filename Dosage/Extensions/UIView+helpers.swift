//
//  UIView+helpers.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-16.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

extension UIView {
    func anchorToSuperview() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
    }
}
