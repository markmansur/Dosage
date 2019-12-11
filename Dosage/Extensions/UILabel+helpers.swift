//
//  UILabel+helpers.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-10.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String = "", textColor: UIColor = .black, font: UIFont, textAlignment: NSTextAlignment = .natural) {
        self.init(frame: CGRect.zero)
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        translatesAutoresizingMaskIntoConstraints = false
    }
}
