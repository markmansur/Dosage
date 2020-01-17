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
        
        setupTabBarItem()
    }
    
    private func setupTabBarItem() {
        tabBarItem.selectedImage = UIImage(named: "tab-icon-pill")
        tabBarItem.image = UIImage(named: "tab-icon-pill")
        tabBarItem.title = ""
        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor(named: "darkGreen") ?? UIColor.green], for: .normal)
    }
}
