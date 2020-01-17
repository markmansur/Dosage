//
//  MainTabBarController.swift
//  Dosage
//
//  Created by Mark Mansur on 2020-01-08.
//  Copyright © 2020 Mark Mansur. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let medicationsNavController = MedicationsNavigationController(rootViewController: MedicationsController())
        
        viewControllers = [medicationsNavController, CalendarController()]
    }
}
