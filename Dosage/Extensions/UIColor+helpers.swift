//
//  UIColor+helpers.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-06.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
}
