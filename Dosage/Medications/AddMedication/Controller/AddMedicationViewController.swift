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
    
    let shapesViewController = ShapesViewController()
    let dosageViewController = DosageViewController()
    
    override func loadView() {
        let addMedicationView = AddMedicationView(shapesView: shapesViewController.view, dosageView: dosageViewController.view)
        addMedicationView.cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        addMedicationView.addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        addMedicationView.datePickerHeaderView.delegate = self
        addMedicationView.datePicker.addTarget(self, action: #selector(handleDateChange(sender:)), for: .valueChanged)
        addMedicationView.setupSubViews()
        view = addMedicationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMedicationView = view as? AddMedicationView
        addChild(shapesViewController)
        addChild(dosageViewController)
        
        shapesViewController.didMove(toParent: self)
        dosageViewController.didMove(toParent: self)
    }
    
    // MARK: Handlers
    @objc private func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleAdd() {
        guard let name = addMedicationView?.nameTextField.text else { return }
        guard let startDate = addMedicationView?.datePickerHeaderView.leftDate else { return }
        guard let endDate = addMedicationView?.datePickerHeaderView.rightDate else { return }
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
    
    @objc private func handleDateChange(sender: UIDatePicker) {
        guard let addMedicationView = view as? AddMedicationView else { return }
        let date = addMedicationView.datePicker.date
        
        switch addMedicationView.datePickerHeaderView.selectedState {
            case .left:
                addMedicationView.datePickerHeaderView.leftDate = date
            case .right:
                addMedicationView.datePickerHeaderView.rightDate = date
            case .none:
                break
        }
    }
}

extension AddMedicationViewController: DatePickerHeaderViewDelegate {
    
    func headerStateDidChange(state: SelectedState) {
        guard let addMedicationView = view as? AddMedicationView else { return }
        
        switch state {
            case .left:
                addMedicationView.showDatePicker()
            case .right:
                addMedicationView.showDatePicker()
            case .none:
                addMedicationView.hideDatePicker()
        }
    }
}
