//
//  Shape.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-09.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

enum Shape: Int, CaseIterable {
    case shape1 = 1
    case shape2 = 2
    case shape3 = 3
    
    var image: UIImage? {
        switch self {
        case .shape1:
            return UIImage(named: "shape1")
        case .shape2:
            return UIImage(named: "shape2")
        case .shape3:
            return UIImage(named: "shape3")
        }
    }
}
