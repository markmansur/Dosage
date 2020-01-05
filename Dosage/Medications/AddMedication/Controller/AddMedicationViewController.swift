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
    var addMedicationControllerDelegate: AddMedicationControllerDelegate?
    var addMedicationView: AddMedicationView?
    
    let startEndDataPickerController = StartEndDatePickerController()
    let shapesViewController = ShapesViewController()
    let dosageViewController = DosageViewController()
    let selectedTimesController = SelectedTimesController()
    
    override func loadView() {
        let addMedicationView = AddMedicationView(startEndDatePickerView: startEndDataPickerController.view,shapesView: shapesViewController.view, dosageView: dosageViewController.view, selectedTimesView: selectedTimesController.view)
        selectedTimesController.delegate = self
        addMedicationView.cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        addMedicationView.addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        addMedicationView.setupSubViews()
        view = addMedicationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationBar.isHidden = true
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
        let dosageTimes = selectedTimesController.selectedTimes
        
        let medication = CoreDataManager.shared.addMedication(name: name, shape: shape, startDate: startDate, endDate: endDate, dosageDays: dosageDays, dosageTimes: dosageTimes)
        dismiss(animated: true) {
            self.addMedicationControllerDelegate?.didAddMedication(medication: medication)
        }
    }
    
    @objc private func handleCancel() {
        dismiss(animated: true)
    }
    
    
}

extension AddMedicationViewController: SelectedTimesControllerDelegate {
    func didTapAddTime() {
        let addTimeController = AddTimeController()
        addTimeController.delegate = self
        navigationController?.pushViewController(addTimeController, animated: true)
    }
}

extension AddMedicationViewController: AddTimeControllerDelegate {
    func didAddTime(time: Time) {
        selectedTimesController.addTime(time: time)
    }
}
