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
    var addMedicationView: AddMedicationView?
    
    let startEndDataPickerController = StartEndDatePickerController()
    let shapesViewController = ShapesViewController()
    let dosageViewController = DosageViewController()
    
    override func loadView() {
        let addMedicationView = AddMedicationView(startEndDatePickerView: startEndDataPickerController.view,shapesView: shapesViewController.view, dosageView: dosageViewController.view)
        addMedicationView.cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        addMedicationView.addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        addMedicationView.setupSubViews()
        view = addMedicationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMedicationView = view as? AddMedicationView
        addChild(shapesViewController)
        addChild(dosageViewController)
        addChild(startEndDataPickerController)
        
        shapesViewController.didMove(toParent: self)
        dosageViewController.didMove(toParent: self)
        startEndDataPickerController.didMove(toParent: self)
    }
    
    // MARK: Handlers
    @objc private func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleAdd() {
        guard let name = addMedicationView?.nameTextField.text else { return }
        guard let startDate = startEndDataPickerController.startDate() else { return }
        guard let endDate = startEndDataPickerController.endDate() else { return }
        let shape = shapesViewController.selectedShape()
        let dosageDays = dosageViewController.selectedDosageDays()
        
        let medication = CoreDataManager.shared.addMedication(name: name, shape: shape, startDate: startDate, endDate: endDate, dosageDays: dosageDays)
        dismiss(animated: true) {
            self.delegate?.didAddMedication(medication: medication)
        }
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true)
    }
    
    
}
