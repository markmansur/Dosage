//
//  MedicationsNavigationController.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-06.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

class MedicationsNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = UIColor(r: 76, g: 199, b: 128, alpha: 1)
        appearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationBar.prefersLargeTitles = true
        
        navigationBar.compactAppearance = appearence
        navigationBar.standardAppearance = appearence
        navigationBar.scrollEdgeAppearance = appearence
        
        
    }
}
