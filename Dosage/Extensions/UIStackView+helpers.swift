//
//  UIStackView+helpers.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-09.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], spacing: CGFloat, axis: NSLayoutConstraint.Axis = .horizontal) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = spacing
        self.axis = axis
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
