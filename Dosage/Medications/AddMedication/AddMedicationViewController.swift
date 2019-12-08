//
//  AddMedicationViewController.swift
//  Dosage
//
//  Created by Mark Mansur on 2019-12-07.
//  Copyright © 2019 Mark Mansur. All rights reserved.
//

import UIKit

protocol AddMedicationControllerDelegate {
    func didAddMedication(medication: Medication)
}

class AddMedicationViewController: UIViewController {
    
    // MARK: Properties
    var delegate: AddMedicationControllerDelegate?
    
    override func loadView() {
        view = AddMedicationView(addHandler: handleAdd)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 65
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // MARK: Handlers
    @objc private func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    private func handleAdd(name: String) {
        print(name)
    }
}
